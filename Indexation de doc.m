%liste des mots vides 
customStopWords = [stopWords "Le" "La" "d" "'" "de" "le"  "la"  "est" "un"]; 

filename = "sonnetsPreprocessed.txt";
str = extractFileText(filename);

%Document 1 : 
D1= {'Le', 'professeur', 'parle' ,'de', 'la', 'recherche', 'd','information'}  ; 
%removing words from Document1 
%divise le document en mot 
documents1 = tokenizedDocument(D1); 
%supprime les mots spécifiés des documents
documents = removeWords(documents1,customStopWords);
documents(1:8) 

%Document 2 : 
D2 ={'La', 'recherche', 'd','information' ,'est', 'un', 'domaine', 'de', 'recherche'} ; 
%removing words from Document2  
%divise le document en mot 
documents2 = tokenizedDocument(D2); 
%supprime les mots spécifiés des documents
documents02 = removeWords(documents2,customStopWords);
documents02(1:9) 

%Document 3 : 
D3 ={ 'Le', 'modele', 'vectoriel', 'de', 'recherche' ,'d','information' ,'est' ,'simple' } ; 
%removing words from Document3
%divise le document en mot 
documents3 = tokenizedDocument(D3); 
%supprime les mots spécifiés des documents
documents03 = removeWords(documents3,customStopWords);
documents03(1:9) 

%bag : enregistre le nombre de fois que les mots apparaissent dans chaque document d'une collection

%BAGdoc1
bag = bagOfWords(documents) 
tbl = topkwords(bag,8)
%BAGdoc2
bag = bagOfWords(documents02) 
tbl = topkwords(bag,8)
%BAGdoc3 
bag = bagOfWords(documents03) 
tbl = topkwords(bag,8)

%SPLIT: divise str en caractères d'espacement 

D1 = split(str,newline);
documents = tokenizedDocument(D1);
bag = bagOfWords(documents)
M = tfidf(bag);
full(M(1:8,1:8))


D2 = split(str,newline);
documents2 = tokenizedDocument(D2);
bag1 = bagOfWords(documents2)
M = tfidf(bag1);
full(M(1:9,1:9))

D3 = split(str,newline);
documents3 = tokenizedDocument(D3);
bag2 = bagOfWords(documents3)
M = tfidf(bag2);
full(M(1:9,1:9))

%Requête : 

B={'information', 'recherche', 'modele', 'simple' } ;
D01= {'professeur', 'parle' ,  'recherche', 'information'}  ; 
out=zeros(size(D01)); 
[n1,n2] = size(D01) ;
for k=1 :n2 
    idx=ismember(D01,B(k)) ; 
    out(:,k)=sum(idx,2); 
end 
disp(out) 

B={'information', 'recherche', 'modele', 'simple' } ;
D02= {'recherche','information' , 'domaine', 'recherche'} ;  
out=zeros(size(D02)); 
[n1,n2] = size(D02) ;
for k=1 :n2 
    idx=ismember(D02,B(k)) ; 
    out(:,k)=sum(idx,2); 
end 
disp(out) 

B={'information', 'recherche', 'modele', 'simple','donnee' } ;
D03= {'modele', 'vectoriel', 'recherche' , 'information' ,'simple' } ; 
out=zeros(size(D03)); 
[n1,n2] = size(D03) ;
for k=1 :n2 
    idx=ismember(D03,B(k)) ; 
    out(:,k)=sum(idx,2); 
end 
disp(out) 


ntests = 100000;
tic
for k=1:length(D01)
    s = D01{k};
    for n=1:ntests
        b = any(strcmp(s,B)); 
    end
end
t=toc;
fprintf('any(strcmp(s,B)): %f\n', t);


ntests = 100000;
tic
for k=1:length(D02)
    s = D02{k};
    for n=1:ntests
        b = any(strcmp(s,B)); 
    end
end
t=toc;
fprintf('any(strcmp(s,B)): %f\n', t);


ntests = 100000;
tic
for k=1:length(D03)
    s = D03{k};
    for n=1:ntests 
        b = any(strcmp(s,B)); 
    end
end
t=toc;
fprintf('any(strcmp(s,B)): %f\n', t); 
