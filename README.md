# 📊 Estudio Estadístico de Factores de Riesgo Asociados con la Obesidad

> *Un análisis multivariante exhaustivo para identificar patrones y factores de riesgo en obesidad*

![R](https://img.shields.io/badge/R-276DC3?style=for-the-badge&logo=r&logoColor=white)
![Status](https://img.shields.io/badge/Status-Completed-success?style=for-the-badge)
![License](https://img.shields.io/badge/License-Academic-blue?style=for-the-badge)

---

## 📋 Tabla de Contenidos

- [🎯 Visión General](#-visión-general)
- [🔬 Metodologías Aplicadas](#-metodologías-aplicadas)
- [📈 Dataset y Variables](#-dataset-y-variables)
- [🏆 Principales Hallazgos](#-principales-hallazgos)
- [⚡ Resultados de Rendimiento](#-resultados-de-rendimiento)
- [🛠️ Tecnologías](#️-tecnologías)
- [🚀 Cómo Usar](#-cómo-usar)
- [📊 Visualizaciones](#-visualizaciones)
- [💡 Conclusiones](#-conclusiones)

---

## 🎯 Visión General

Este proyecto presenta un **análisis estadístico multivariante exhaustivo** diseñado para descifrar los misterios detrás de los factores de riesgo asociados con la obesidad. 

**¿Por qué es importante?** 🤔
- Contribuye al desarrollo de **estrategias de prevención personalizadas**
- Identifica patrones ocultos en los datos de salud
- Proporciona insights para profesionales de la salud

**Nuestro enfoque:** Aplicamos 5 técnicas estadísticas complementarias para obtener una visión 360° del problema.

---

## 🔬 Metodologías Aplicadas

Cada técnica fue seleccionada estratégicamente para revelar diferentes aspectos de los datos:

### 🎪 **PCA (Análisis de Componentes Principales)**
```
🎯 Objetivo: Reducir dimensionalidad e identificar patrones principales
📊 Resultado: 41.3% de variabilidad explicada
⭐ Insight: Peso, altura y edad son las variables más influyentes
```

### 🎯 **LDA (Análisis Discriminante Lineal)**
```
🎯 Objetivo: Clasificación óptima entre tipos de obesidad
📊 Resultado: 85% de precisión
⭐ Insight: Excelente para casos extremos (peso insuficiente y obesidad tipo III)
```

### 🧩 **Análisis de Clúster**
```
🎯 Objetivo: Descubrir grupos naturales en los datos
📊 Resultado: 2-3 clusters óptimos identificados
⭐ Insight: Clara separación entre individuos obesos y no obesos
```

### 🎲 **Naive Bayes**
```
🎯 Objetivo: Clasificación probabilística
📊 Resultado: 70% accuracy (78% con categorías reducidas)
⭐ Insight: Muy efectivo para obesidad tipos 2 y 3
```

### ❌ **PLS (Evaluación Crítica)**
```
🎯 Objetivo: Evaluar aplicabilidad
📊 Resultado: No recomendado
⭐ Insight: Inadecuado para clasificación multiclase
```

---

## 📈 Dataset y Variables

### 📊 **Composición del Dataset**
- **15 variables predictoras** + 1 variable objetivo
- **Tipos de datos:** Mixtos (numéricos y categóricos)
- **Enfoque:** Desde características físicas hasta hábitos de vida

### 🔢 **Variables Numéricas**
| Variable | Descripción | Unidad |
|----------|-------------|---------|
| `Height` | Altura | Metros |
| `Weight` | Peso | Kilogramos |
| `Age` | Edad | Años |
| `FCVC` | Consumo de vegetales | Frecuencia |
| `NCP` | Comidas principales | Número/día |
| `CH2O` | Consumo de agua | Litros/día |
| `FAF` | Actividad física | Frecuencia |
| `TUE` | Uso de tecnología | Horas/día |

### 🏷️ **Variables Categóricas**
- **👥 Demográficas:** Género
- **🧬 Genéticas:** Antecedentes familiares de sobrepeso
- **🍔 Alimenticias:** Consumo de alimentos calóricos, snacking
- **🏃 Actividad:** Frecuencia de ejercicio, medio de transporte
- **🚬 Hábitos:** Tabaquismo, consumo de alcohol

---

## 🏆 Principales Hallazgos

### 🎯 **Top 3 Factores de Riesgo**

1. **🏋️ Variables Antropométricas**
   - Peso y altura = predictores más significativos
   - Confirmado en **TODOS** los análisis realizados

2. **📅 Factor Edad**
   - Variable crucial para clasificación
   - Importante en agrupación de casos

3. **⚖️ Relación Peso-Altura**
   - Similar al concepto de IMC
   - Factor clave en identificación de grupos de riesgo

### 💡 **Insights Sorprendentes**

> **🔍 Heterogeneidad Intra-Grupo:** Los análisis revelaron subgrupos específicos dentro de cada categoría de obesidad, sugiriendo que "no todas las obesidades son iguales".

> **🎯 Separación Clara:** Existe una división natural entre individuos obesos y no obesos, pero las categorías intermedias presentan mayor solapamiento.

---

## ⚡ Resultados de Rendimiento

### 🏅 **Ranking de Modelos**

| Modelo | Accuracy | 🌟 Fortaleza | ⚠️ Limitación |
|--------|----------|---------------|----------------|
| **LDA** | **85%** | Casos extremos | Solo variables numéricas |
| **Naive Bayes** | **70-78%** | Versatilidad | Asume independencia |
| **Clusters** | **N/A** | Patrones naturales | No supervisado |
| **PCA** | **41.3%** varianza | Reducción dimensional | Interpretabilidad |

### 📊 **Matriz de Confusión - LDA**
```
Precisión por Categoría:
✅ Peso Insuficiente: 92% (83/90 casos)
✅ Obesidad Tipo III: ~90%
⚠️ Sobrepeso Niveles: 60-70%
```

---

## 🛠️ Tecnologías

### 💻 **Stack Tecnológico**

```r
# Core Analytics
📦 FactoMineR     # Análisis multivariante
📦 factoextra     # Visualizaciones elegantes
📦 MASS           # LDA implementation

# Machine Learning
📦 e1071          # Naive Bayes
📦 caret          # Model evaluation

# Visualización
📦 ggplot2        # Gráficos profesionales
📦 GGally         # Matrices de correlación
```

### 🎨 **Visualizaciones Incluidas**
- 📈 Gráficos de dispersión multivariantes
- 🎪 Biplots de PCA con variables suplementarias
- 🎯 Proyecciones discriminantes
- 🧩 Dendrogramas de clustering
- 📊 Matrices de confusión interactivas

---

## 🚀 Cómo Usar

### 📋 **Prerrequisitos**
```r
# Instalar paquetes necesarios
install.packages(c("readxl", "factoextra", "FactoMineR", 
                   "MASS", "ggplot2", "GGally", "caret", "e1071"))
```

### ▶️ **Ejecución**
```bash
# 1. Clonar el repositorio
git clone [repository-url]

# 2. Preparar datos
# Colocar 'Obesidad.xlsx' en el directorio raíz

# 3. Ejecutar análisis completo
Rscript factores_riesgo.R
```

### 📁 **Estructura de Archivos**
```
📁 Proyecto/
├── 📄 factores_riesgo.R    # Análisis principal
├── 📊 Obesidad.xlsx        # Dataset
├── 📋 README.md            # Esta documentación
└── 📈 outputs/             # Gráficos generados
```

---

## 📊 Visualizaciones

El análisis genera automáticamente:

🎨 **Exploratorias**
- Histogramas de distribución
- Matrices de correlación coloreadas por clase

🔬 **Analíticas**
- Biplots de PCA con elipses de confianza
- Proyecciones LDA multiclase
- Gráficos de clustering con PCA

📈 **Evaluativas**
- Matrices de confusión heat-map
- Curvas de precisión por clase

---

## 💡 Conclusiones

### 🎯 **Mensaje Clave**

> La obesidad es un fenómeno **multifactorial** que requiere un enfoque integrado. Nuestro análisis demuestra que aunque las variables antropométricas son predictores poderosos, la comprensión completa requiere considerar múltiples dimensiones del comportamiento humano.

### 🔮 **Implicaciones Futuras**

- **👨‍⚕️ Para profesionales de salud:** Enfoques personalizados basados en perfiles de riesgo
- **📊 Para investigadores:** Framework metodológico para estudios similares  
- **🏥 Para políticas públicas:** Estrategias de prevención basadas en evidencia

### 🌟 **Valor Académico**

Este proyecto demuestra:
- ✅ Dominio de análisis estadístico multivariante
- ✅ Capacidad de interpretación de resultados complejos
- ✅ Implementación práctica de múltiples metodologías
- ✅ Comunicación efectiva de hallazgos científicos

---

<div align="center">

### 🎓 **Parte del Portfolio Académico**
**Ciencia e Ingeniería de Datos | Universidad Autónoma de Madrid**

*Transformando datos en conocimiento*

</div>

---

**📧 ¿Preguntas o colaboraciones?** ¡No dudes en contactar!