# Estimation Module

The **LabRI method** is an adaptive and multi-criteria approach for the **indirect estimation and verification** of reference intervals. It integrates data cleaning, data transformation, clustering techniques, and applies the `refineR`, `reflimR`, and **Expectation-Maximization (EM)** algorithms. The method combines **parametric and non-parametric percentile** approaches to estimate population reference intervals, depending on the number of clusters identified in the truncated distribution.

## Characteristics of the LabRI Method

- **Adaptive**: 
  - Adjusts its application based on the structure and characteristics of the data, using different cleaning and transformation techniques as needed.
  - Applies the **Centroid of Windsorized Reference Limits** method using `refineR` and `reflimR` if the data distribution has more than one cluster for reference interval estimation.
  - If there is only one cluster, the expectation-maximization algorithm is used with both parametric and non-parametric approaches to obtain the best reference interval estimate.

- **Multi-criteria**:
  - Considers multiple criteria and methods for the estimation and verification of reference intervals, ensuring a robust and comprehensive analysis.
