#!/bin/bash

#Creo la carpeta en HDFS
hdfs dfs -mkdir /pruebas

#Copio el archivo de datos al sistema de archivos HDFS
hdfs dfs -copyFromLocal archivos_hadoop/medidas.txt /pruebas

#Borro la carpeta output si existia antes
hdfs dfs -rm -r /pruebas/output

#Lanzo el trabajo de MapReduce
mapred streaming -files archivos_hadoop/mapper_1.py,archivos_hadoop/reducer_1.py -mapper "python3 mapper_1.py" -reducer "python3 reducer_1.py" -input hdfs:///pruebas/medidas.txt -output hdfs:///pruebas/output

#Resultados
hdfs dfs -cat /pruebas/output/part-00000
