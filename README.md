# Ayahuasca_Fingerprints
Code and materials for  "Ritualistic use of ayahuasca enhances a shared functional connectome identity with others", as implemented in MATLAB 2019b.

Connectome fingerprinting allows for the assessement of a subject's connectome identifiability across experimental conditions by generating a "Identifiability Matrix" (Amico & Goñi, Scientific Reports 2018). The code serves to compares two functional connectome (FC) acquisitions/sessions for each subject (defined as test and retest) and gives the resultant pearson similarity matrix. Its main diagonal (top left to bottom right) highlights the self-identifiability (Iself) of the sample, i.e. the similarity between the test and retest FC of the same subject. The remaining elements consists in the comparison between test and retest FC of different subjects (Iothers). By computing all possible test-retest combinations we can extend this idea by comparing individual connectomes (ie: their distance) between different populations or conditions and generate "Hybrid" equivalents of each score. 


The following code generates:<br/>
Fig.2: Static connectome fingerprints<br/> 
Fig.3: Dynamic connectome fingerprints<br/> 
Fig.4: Static ICC<br/> 
Fig.5: Dynamic ICC<br/>
Fig.6: PCA MLR prediction of behaviour<br/> 


We'll next be implementing framewise dynamical approaches for identifiability & behaviour prediction as well as a broader ranger of parcellation types, hallucinogens and modalities. Stay tuned! 


**Requirements**:
Your starting functional connectomes should be time(TRs) x regions x subjects structure (across conditions). From this we will derive test-retest splits. Of course if you have multiple aquisitions in each session instead don't let that stop you! You can just restructure according to restructure_mats.mat.


PLEASE NOTE: Unfortunately due to IRB constraints, we were not able to make subject-level data available without a prior data sharing agreement.  Please contact p.mallaroni@maastrichtuniversity.nl for a (vetted) exchange of all identifying data.


**Please obtain the following toolboxes for**:<br/>
Visualisations: https://github.com/bastibe/Violinplot-Matlab<br/>
Renders: https://www.nitrc.org/projects/bnv/<br/>


_Authors: Pablo Mallaroni, Enrico Amico_



**The included code is in part adapted from the following publications and their corresponding repositories so please do cite them!**
 Dimitri Van De Ville, Younes Farouj, Maria Giulia Preti, Raphaël Liégeois, Enrico Amico "When makes you unique: Temporality of the human brain fingerprint ", Science Advances 2021 https://www.science.org/doi/10.1126/sciadv.abj0751
https://github.com/eamico/Dynamic_fingerprints

Ekansh Sareen, Sélima Zahar, Dimitri Van De Ville, Anubha Gupta, Alessandra Griffa, Enrico Amico, "Exploring MEG brain fingerprints: Evaluation, pitfalls, and interpretations", NeuroImage, 2021, https://doi.org/10.1016/j.neuroimage.2021.118331
https://github.com/eamico/MEG_fingerprints

Sorrentino, Pierpaolo, Rosaria Rucco, Anna Lardone, Marianna Liparoti, Emahnuel Troisi Lopez, Carlo Cavaliere, Andrea Soricelli, Viktor Jirsa, Giuseppe Sorrentino, and Enrico Amico. "Clinical connectome fingerprints of cognitive decline", NeuroImage 2021, doi.org/10.1016/j.neuroimage.2021.118253
https://github.com/eamico/Clinical_fingerprinting
