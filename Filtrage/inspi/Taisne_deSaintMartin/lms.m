function [sortie,erreur,coefs] = lms(entree,desire,coefs_init,mu,nb_coefs_enregistres)

Us = zeros(1,nb_coefs_enregistres);        
coefs = coefs_init;
for i=nb_coefs_enregistres:length(entree)
    Us(1,2:end) = Us(1,1:end-1);  
    Us(1,1) = entree(i);               
    sortie(i) = (coefs)*Us';             
    erreur(i) = desire(i) - sortie(i);                 
    coefs = coefs +  mu * erreur(i) * Us;  
end