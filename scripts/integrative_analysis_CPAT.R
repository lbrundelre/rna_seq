######################get coding potential of transcripts#######################

#set working directory
setwd("C:/Users/livbr/bioinformatics/rna_seq")

#code created by CPAT
load("Human_logitModel.RData")
test <- read.table(file="coding_potential.dat",sep="\t",col.names=c("target_id","mRNA","ORF","Fickett","Hexamer"))
test$prob <- predict(mylogit,newdata=test,type="response")
attach(test)
coding_potential <- cbind("mRNA_size"=mRNA,"ORF_size"=ORF,"Fickett_score"=Fickett,"Hexamer_score"=Hexamer,"coding_prob"=test$prob)

#save as table
write.table(coding_potential,file="coding_potential",quote=F,sep="\t",row.names=ID)

