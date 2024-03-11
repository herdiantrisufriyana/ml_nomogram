# Nomogram for a machine learning model with categorical predictors to predict binary outcome

Herdiantri Sufriyana, MD, PhD; a, b Emily Chia-Yu Su, PhD a, c, d, *

a Graduate Institute of Biomedical Informatics, College of Medical Science and 
Technology, Taipei Medical University, 250 Wu-Xing Street, Taipei 11031, 
Taiwan.
b Department of Medical Physiology, Faculty of Medicine, Universitas Nahdlatul 
Ulama Surabaya, 57 Raya Jemursari Road, Surabaya 60237, Indonesia.
c Clinical Big Data Research Center, Taipei Medical University Hospital, 250 
Wu-Xing Street, Taipei 11031, Taiwan.
d Research Center for Artificial Intelligence in Medicine, Taipei Medical 
University, 250 Wu-Xing Street, Taipei 11031, Taiwan.
\* Corresponding author at:Graduate Institute of Biomedical Informatics, 
College of Medical Science and Technology, Taipei Medical University, 250 
Wu-Xing Street, Taipei 11031, Taiwan. Phone: +886-2-66202589 ext. 10931.

The preprint can be found here:
(soon)

The journal article will be published soon.

Supplementary Information and other files can be found in any of above 
publications.


## System requirements

We used R 4.2.3 programming language (R Foundation, Vienna, Austria) to conduct 
all procedures, except to train the machine learning (ML) models and to obtain 
their variable importance. These procedures were conducted using Python 3.11.8. 
For R and Python, the integrated development environment software was 
respectively RStudio 2023.03.0 (RStudio PBC, Boston, MA, USA) and jupyterlab 
4.0.11. To ensure reproducibility, we used renv 0.17.3 and Bioconductor 3.16 
for R;20 and conda 4.12.0 for Python. For machine learning, we used a Python 
library of scikit-learn 1.2.2 and xgboost 1.7.3. Details on other R package and 
Python library versions and all of the source codes (vignette) for the data 
analysis are available in 
[ml_nomogram.Rmd](https://github.com/herdiantrisufriyana/ml_nomogram/blob/master/ml_nomogram.Rmd) 
and 
[ml_nomogram.ipynb](https://github.com/herdiantrisufriyana/ml_nomogram/blob/master/ml_nomogram.ipynb).

To reproduce our work, a set of hardware requirements may be needed. We used a 
single machine. It was equipped by 8 logical processors for the 3.40 GHz 
central processing unit (CPU) (Core i7-4770, Intel®, Santa Clara, CA, USA), 
and 16 GB RAM. However, one can use a machine with only 4 logical processors 
and 4 GB RAM.


## Installation guide

Please follow through the R Markdown 
([ml_nomogram.Rmd](https://github.com/herdiantrisufriyana/ml_nomogram/blob/master/ml_nomogram.Rmd)) 
and the Jupyter Lab Notebook 
([ml_nomogram.ipynb](https://github.com/herdiantrisufriyana/ml_nomogram/blob/master/ml_nomogram.ipynb)). 
Installation approximately requires ~15 minutes.


## Demo

All codes require ~15 minutes to complete. We use a benchmark dataset, i.e., 
the Wisconsin Breast Cancer Dataset, for this protocol. Please follow through 
the vignettes. These show simple examples to demo the protocol.


## Instructions for use

Briefly, all system requirements, installation guide, demo, and instructions 
for use are available in R Markdown 
([ml_nomogram.Rmd](https://github.com/herdiantrisufriyana/ml_nomogram/blob/master/ml_nomogram.Rmd)), 
except to train the models and to obtain their variable importance 
([ml_nomogram.ipynb](https://github.com/herdiantrisufriyana/ml_nomogram/blob/master/ml_nomogram.ipynb)).
