# Importamos librerías necesarias
library(readxl)
library(factoextra)
library(FactoMineR)
library(pls)
library(MASS)
library(ggplot2)
library(GGally)
library(plsVarSel)
library(caret)
library(e1071)


set.seed(123)

#######################################################################
##################### Visualización de los datos ######################
#######################################################################

# Cargamos los datos
datos <- read_excel('Obesidad.xlsx', sheet = 2)

# Crear un layout más manejable (4 gráficos por grupo)
par(mfrow = c(2, 2)) # 2 filas y 2 columnas
par(mar = c(4, 4, 2, 1)) # Márgenes más pequeños

# Visualizar la distribución de las variables numéricas
numericas <- c("Age", "Height", "Weight", "FCVC", "NCP", "CH2O", "FAF", "TUE")

# Dibujar los histogramas en grupos
for (i in seq_along(numericas)) {
  hist(datos[[numericas[i]]], 
       main = paste("Distribución de", numericas[i]), 
       xlab = numericas[i], 
       col = "skyblue", 
       border = "white")
}

# Seleccionar las variables numéricas y la clase
datos_subset <- datos[, c(numericas, "Obesity_level")]

# Convertir Obesity_level en factor (requerido para ggplot)
datos_subset$Obesity_level <- as.factor(datos_subset$Obesity_level)

# Graficar con ggpairs y ajustar tamaño de texto de correlaciones
ggpairs(
  datos_subset,
  aes(color = Obesity_level, alpha = 0.7),
  columns = numericas, # Variables numéricas
  diag = list(continuous = wrap("densityDiag", alpha = 0.5)), # Gráficos en la diagonal
  upper = list(continuous = wrap("cor", size = 2.5)),         # Reducir tamaño del texto de correlaciones
  lower = list(continuous = "points")                        # Puntos en la parte inferior
)

#######################################################################
################################ PCA ##################################
#######################################################################

# Convertimos todas las variables categóricas a factor para poder modelizar PCA como se ha explicado en la memoria
categorical_columns = c("Gender", "family_history_with_overweight", "FAVC", 
                         "CAEC", "SMOKE", "SCC", "CALC", "MTRANS", "Obesity_level")
datos[categorical_columns] = lapply(datos[categorical_columns], function(x) as.factor(x))

# Identificar las columnas numéricas
numeric_columns = setdiff(names(datos), categorical_columns)

# Estandarizamos las variables numéricas
datos[numeric_columns] <- scale(datos[numeric_columns])

# Aplicar PCA sobre las variables numéricas teniendo en cuenta las categóricas como suplementarias
pca <- PCA(datos, ncp = 8, graph = TRUE, quali.sup = categorical_columns)

# Varianza explicada por cada componente
fviz_screeplot(pca, addlabels = TRUE)

# Visualización de individuos (con puntos coloreados según las categorías de las variables suplementarias)
fviz_pca_ind(pca, habillage = categorical_columns, addEllipses = TRUE)

# Visualización de las variables en el espacio PCA (con flechas que indican las variables)
fviz_pca_var(pca)
fviz_pca_ind(pca, habillage = "Obesity_level", addEllipses = TRUE)


#######################################################################
################################ LDA ##################################
#######################################################################

# Cargamos los datos de nuevo
datos = read_excel('Obesidad.xlsx', sheet = 2)

# dejamos solo las variables numéricas y la variable target
datos = datos[, !(colnames(datos) %in% c("Gender", "family_history_with_overweight", "FAVC", 
                                          "CAEC", "SMOKE", "SCC", "CALC", "MTRANS"))]

# Separamos 2 conjuntos de train y test para poder evaluar la eficacia de nuestro modelo
indices = sample(1:nrow(datos), size = 0.7 * nrow(datos))
train = datos[indices, ]
test = datos[-indices, ]

# Ajustamos el modelo LDA
model = lda(Obesity_level~., data=train)
model

# Proyectamos los datos de entrenamiento en el espacio de discriminantes
lda.values = predict(model, train)

# Convertimos las proyecciones y clases a un data frame
lda.data = data.frame(LD1 = lda.values$x[, 1],  # Primera función discriminante
                       LD2 = lda.values$x[, 2],  # Segunda función discriminante
                       Class = train$Obesity_level)  # Clases verdaderas

ggplot(data = lda.data, aes(x = LD1, y = LD2, color = Class)) +
  geom_point(size = 3, alpha = 0.7) +
  labs(title = "Proyección en las primeras dos funciones discriminantes (LDA Multiclase)",
       x = "Primera función discriminante (LD1)",
       y = "Segunda función discriminante (LD2)") +
  theme_minimal() +
  scale_color_manual(values = c("red", "blue", "green", "purple", "orange", "brown", "yellow")) +
  theme(legend.title = element_text(size = 10),
        legend.text = element_text(size = 8)) +
  coord_cartesian(xlim = c(min(lda.data$LD1), max(lda.data$LD1)), 
                  ylim = c(min(lda.data$LD2), max(lda.data$LD2)))


# Predicciones en conjunto de prueba
lda.pred = predict(model, test)$class

# Matriz de confusión
confusion_matrix = table(test$Obesity_level, lda.pred, dnn = c("Actual", "Predicted"))
confusionMatrix(confusion_matrix)

# Calculamos precisión global
accuracy = sum(diag(confusion_matrix)) / sum(confusion_matrix)
print(paste("Precisión global:", round(accuracy, 2)))


#######################################################################
############################ Naive Bayes ##############################
#######################################################################

# Cargamos los datos de nuevo
datos = read_excel('Obesidad.xlsx', sheet = 2)

#variables peso, edad y altura
indices_continuas = c(2,3,4) 

#estas dos líneas comentadas es el código usado para clasificar sin distinguir los grados de obesidad y por otro lado sobrepeso. Descomentar para probar.
#data$Obesity_level=ifelse(data$Obesity_level %in% c("Overweight_Level_I", "Overweight_Level_II", "Overweight_Level_III"),'Overweight',data$Obesity_level)
#data$Obesity_level=ifelse(data$Obesity_level %in% c("Obesity_Type_I", "Obesity_Type_II", "Obesity_Type_III"),'Obesity',data$Obesity_level)

#redondeamos las variables continuas problemáticas a las unidades para luego tratarlas como cualitativas con as.factor.
for (i in c(8,7,11,13,14)) {
  datos[,i] = round(datos[,i], digits=0)
}

#as.numeric si es peso, edad o altura, en caso contrario se trata la variable con as.factor
for (i in 1:ncol(datos)){
  print(i)
  if (i %in% indices_continuas) {datos[,i]= as.numeric(unlist(datos[,i]))}
  else {datos[,i]= as.factor(unlist(datos[,i]))}
}

# Separamos 2 conjuntos de train y test para poder evaluar la eficacia de nuestro modelo
indices = sample(1:nrow(datos), size = 0.7 * nrow(datos))
train = datos[indices, ]
test = datos[-indices, ]

#normalización de las variables continuas, tanto en train como en test, de forma separada
train[indices_continuas] = scale(train[indices_continuas])
test[indices_continuas] = scale(test[indices_continuas])

y_test=unlist(test[,ncol(test)])

#creación y entrenamiento con train del modelo naive bayes donde le indicamos que la variable objetivo es el nivel de obesidad.
classifier_cl = naiveBayes(Obesity_level ~ . ,data=train)
classifier_cl

# Predicciones con el conjunto test, se muestra la matriz de confusión
y_pred = predict(classifier_cl, newdata = test)
table(y_test, y_pred, dnn = c('Actual Group','Predicted Group'))


#mostrando el accuracy obtenido en test
aciertos = sum(y_test == y_pred)
muestras_test = length(y_test)
print(paste('con el modelo Naive Bayes obtenemos un accuracy en test del',round(aciertos/muestras_test, 3)))


#######################################################################
############################## Clusters ###############################
#######################################################################

# Cargar los datos de nuevo
datos = read_excel('Obesidad.xlsx', sheet = 2)

# Procedemos a convertir las variables categoricas a numericas por medio de transforamciones para poder aplicar el modelo
categorical_columns = c("Gender", "family_history_with_overweight", "FAVC", 
                        "CAEC", "SMOKE", "SCC", "CALC", "MTRANS")

# Renombramos para las visualizaciones
Obesity_level = factor(datos$Obesity_level)
levels(Obesity_level) = c("I", "N", "Ob1", "Ob2", "Ob3", "Ov1", "Ov2")
datos$Obesity_level = Obesity_level

datos[categorical_columns] = lapply(datos[categorical_columns], function(x) as.numeric(as.factor(x)))

# PROCEDEMOS A APLICAR CLUSTER:
datos_sin_target = datos[,-17]

# Método del Codo
fviz_nbclust(datos_sin_target, kmeans, method = "wss") +
  labs(title = "Resultados del método del codo")

# Método de la Silueta
fviz_nbclust(datos_sin_target, kmeans, method = "silhouette") +
  labs(title = "Resultados del método de la silueta")

# K-Means
for (k in 2:3) {
  set.seed(0)
  resultado_kmeans <- kmeans(datos_sin_target, centers = k)
  
  datos$Cluster <- as.factor(resultado_kmeans$cluster)
  
  resultado_pca <- prcomp(datos_sin_target, scale. = TRUE)
  
  print(fviz_pca_ind(resultado_pca, geom = "point", habillage = datos$Cluster, 
                     palette = "jco", addEllipses = TRUE) +
          labs(title = paste("PCA con", k, "Clusters")))
  
  print(ggpairs(datos, columns = c(2, 3, 4, 13, 14, 17), aes(color = Cluster, alpha = 0.7)) +
          labs(title = paste("Relaciones de variables (", k, " Clusters)", sep="")))
}

