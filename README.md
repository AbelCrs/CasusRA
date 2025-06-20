# Gedownreguleerde rac signalering in de B-cel receptor signaalroute bij reumatoïde artritis een genoom analyse. 
<p align="center">
  <img src="Assets/Reumathoid.webp" alt="Reuma" width="2000" />
</p>

------

## 1. Inleiding

Reumatoïde Artritis (RA) is een chronische, inflammatoire auto immuunziekte die wereldwijd miljoenen mensen treft. De aandoening kenmerkt zich door pijnlijke zwelling in de gewrichten, wat op termijn kan leiden tot ernstige gewrichtsschade en functieverlies, en heeft een aanzienlijke impact op de levenskwaliteit van patiënten (Aletaha et al., 2010). De precieze oorzaak van RA is complex, maar een ontregeld immuunsysteem speelt een centrale rol. B cellen, T cellen en pro inflammatoire cytokines dragen bij aan de aanhoudende ontsteking. Het verkrijgen van een dieper inzicht in de moleculaire mechanismen die ten grondslag liggen aan RA is essentieel voor de ontwikkeling van effectievere diagnostische methoden en gerichte therapieën. Het doel van dit onderzoek was dan ook het identificeren van differentieel tot expressie gebrachte genen bij RA patiënten in vergelijking met gezonde individuelen, om zo potentiële biomarkers en ziektegerelateerde pathways te ontdekken. 

## 2. Methode

Workflow is gevisualiseerd met behulp van deze [flowschema](Assets/Flowschema.png)

Dit onderzoek analyseerde RNA-sequencing data van synoviumbiopten van acht patiënten (4 RA, 4 controle), waarbij RA-patiënten ACPA-positief waren met een diagnose van langer dan 12 maanden. De RNA-sequenties werden verkregen via het **Illumina** platform. Alle analyses zijn uitgevoerd in **RStudio (v4.4.2)** met pakketten gedownload via `BiocManager (v1.30.26)`.

### 2.1 Data Preprocessing en Count Matrix Generatie

Ruwe sequencing reads zijn verwerkt met `Rsubread (v2.20.0)` en `Rsamtools (v2.22.0)`. Een referentie-index van het humane genoom (`Homo sapiens`, GRCh38.p14, Ensembl: GCA_000001405.29) werd opgebouwd. Reads werden hiertegen uitgelijnd naar BAM-bestanden en vervolgens gesorteerd en geïndexeerd. De `featureCounts` functie van `Rsubread (v2.20.0)` genereerde de 'count matrix', die het aantal gemapte reads per gen per patiënt vastlegt.

### 2.2 Differentiële Genexpressie Analyse

De count matrix en patiëntstatus werden geanalyseerd met `DESeq2 (v1.46.0)`. Dit resulteerde in fold change-waarden, p-waarden en Benjamini-Hochberg gecorrigeerde p-waarden voor differentiële genexpressie, waarmee significante veranderingen werden geïdentificeerd.

### 2.3 Functionele Analyse en Visualisatie

Functionele analyses en visualisaties omvatten:
* Een **Volcano Plot** om genexpressie te visualiseren, gegenereerd met `EnhancedVolcano (v1.24.0)`.
* Een **Gene Ontology (GO) analyse** met `goseq (v1.58.0)`, ondersteund door `geneLenDataBase (v1.42.0)`, `org.Hs.eg.db (v3.20.0)` en `GO.db (v3.20.0)`.
* Een **KEGG pathway-analyse** met `KEGGREST (v1.46.0)` en visualisatie via `pathview (v1.46.0)`.
* Aanvullende gene set testing is uitgevoerd met `msigdbr (v24.1.0)`.
* Algemene data manipulatie en plotten is uitgevoerd met `readr (v2.1.5)`, `dplyr (v1.1.4)` en `ggplot2 (v3.5.2)`.

Deze analyses boden inzicht in significante genveranderingen en de beïnvloede metabole routes in Reumatoïde Artritis.

Het volledige RStudio-code is [hier](Rscript/Rscript) terug te vinden.

## 3. Resultaten

De resultaten tonen significante verschillen in genexpressiepatronen tussen RA patiënten en gezonde controlepersonen. De Volcano plot [bekijk de Volcano Plot hier](results/Screenshot%202025-06-08%20154951.png)  visualiseert deze differentiële genexpressie over alle 29.407 genen. Een aantal genen toonde significant verhoogde of verlaagde expressie, gedefinieerd door een absolute log2 fold change van meer dan 1.5 en een padj van minder dan 0.05. Dit wijst op moleculaire veranderingen kenmerkend voor RA. De GO analyse [bekijk de Top 10 Verrijkte GO Termen hier](results/Screenshot%252025-06-08%2520154327.png) identificeerde meer aanwezige biologische processen. Zoals verwacht bij een auto immuunziekte, dit waren voornamelijk  de immunoglobulin complex, adaptive immune response en B cel mediated immuniteit. De hoge statistische significantie bevestigt een fundamenteel ander immuunsysteem bij RA. De KEGG pathway analyse [bekijk de B cel Receptor Signaalroute hier](results/hsa04662.pathview.png) liet zien dat de B cel Receptor Signaalroute (hsa04662) genen bevatte die significant verschillend tot expressie kwamen. Binnen de keten Antigen , BTK , BLNK , VAV, Bam32 en Rac waren BTK, BLNK en VAV upregulated (rood). Echter, **Rac** was significant downregulated (groen), met een log2 fold change van ongeveer -3.

## 4. Conclusie

De resultaten bevestigen verschillen in genexpressie tussen RA en gezonde personen; 4572 genen toonden significante activiteitsverschillen. Velen zijn betrokken bij afweersysteem en ontstekingsreacties. GO analyse wees op verstoorde immuunrespons en cytokine activiteit bij reumapatiënten, wat duidt op een afwijkend immuunsysteem. De KEGG analyse benadrukt verstoringen in de B cel Receptor Signaalroute, met name de neerwaartse regulatie van Rac. Deze specifieke verstoring in Rac signalering kan leiden tot abnormale B celfunctie zoals veranderde migratie of defecten in de immuunsynaps, wat bijdraagt aan de complexe pathogenese van RA. Deze bevinding van gedownreguleerd Rac komt overeen met studies die wijzen op de rol van Rac in B cel functionaliteit in autoimmuniteit Concluderend geeft dit onderzoek inzicht in RA op moleculair niveau, waarbij het afweersysteem een grote rol speelt. Deze resultaten kunnen helpen bij het vinden van nieuwe medicijnen of biomarkers. 
