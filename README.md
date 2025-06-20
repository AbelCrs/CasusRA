# Downreguleerde RAC signalering in de B cel receptor signaalroute bij reumatoïde artritis, een genoom analyse. 
<p align="center">
  <img src="Assets/Reumathoid.webp" alt="Reuma" width="2000" />
</p>

------

## **1. Inleiding**

Reumatoïde Artritis (RA) is een chronische, inflammatoire auto immuunziekte die wereldwijd miljoenen mensen treft. De aandoening kenmerkt zich door pijnlijke zwelling in de gewrichten, wat op termijn kan leiden tot ernstige gewrichtsschade en functieverlies, en heeft een aanzienlijke impact op de levenskwaliteit van patiënten (Aletaha et al., 2010). De precieze oorzaak van RA is complex, maar een ontregeld immuunsysteem speelt een centrale rol. B cellen, T cellen en pro inflammatoire cytokines dragen bij aan de aanhoudende ontsteking (Smolen et al., 2016). Het verkrijgen van een dieper inzicht in de moleculaire mechanismen die ten grondslag liggen aan RA is essentieel voor de ontwikkeling van effectievere diagnostische methoden en gerichte therapieën. Het doel van dit onderzoek was dan ook het identificeren van differentieel tot expressie gebrachte genen bij RA patiënten in vergelijking met gezonde individuelen, om zo potentiële biomarkers en ziektegerelateerde pathways te ontdekken. 

## **2. Methode**

Workflow is gevisualiseerd met deze [flowschema](Assets/Flowschema2.png).

Dit onderzoek analyseerde RNA sequencing data van synoviumbiopten van acht patiënten (4 RA, 4 controle), waarbij RA patiënten ACPA positief waren met een diagnose van langer dan 12 maanden. Alle analyses zijn uitgevoerd in **RStudio (v4.4.2)** met pakketten gedownload via `BiocManager (v1.30.26)`.

### **2.1 Data Preprocessing**

Ruwe sequencing reads zijn verwerkt met `Rsubread (v2.20.0)` en `Rsamtools (v2.22.0)`. Een referentie index van het humane genoom (`Homo sapiens`, GRCh38.p14, Ensembl: GCA_000001405.29) werd opgebouwd. Reads werden hiertegen uitgelijnd naar BAM bestanden en vervolgens gesorteerd en geïndexeerd. De `featureCounts` functie van `Rsubread (v2.20.0)` genereerde de 'count matrix', die het aantal gemapte reads per gen per patiënt vastlegt.

### **2.2 Differentiële Genexpressie Analyse**

De count matrix en patiëntstatus werden geanalyseerd met `DESeq2 (v1.46.0)`. Dit resulteerde in fold change waarden, p waarden en Benjamini Hochberg gecorrigeerde p waarden voor differentiële genexpressie, waarmee significante veranderingen werden geïdentificeerd.

### **2.3 Functionele Analyse en Visualisatie**

Voor de functionele analyses en visualisaties van de differentieel tot expressie gebrachte genen zijn de volgende R pakketten en tools gebruikt:

Aanvullende pakketen gebruikt: `EnhancedVolcano (v1.24.0)`, `goseq (v1.58.0)`, `geneLenDataBase (v1.42.0)`, `org.Hs.eg.dB (v3.20.0)` ,`GO.dB (v3.20.0)`, `KEGGREST (v1.46.0)`, `pathview (v1.46.0)`, `readr (v2.1.5)`, `dplyr (v1.1.4)` en `ggplot2 (v3.5.2)`.

Het volledige RStudio code is [hier](Rscript/CasusRAscript.R) terug te vinden.

## **3 Resultaten**

De analyse van RNA sequencing data omvatte differentiële genexpressie (volcano plot) en functionele verrijkingsanalyses (GO en KEGG), met een gerichte focus op B cel gerelateerde signalering.

### **3.1 Differentiële genexpressie**

De [Volcano plot](results/Volcano.png) toonde significante verschillen in genexpressie tussen RA patiënten en controles. Genen waren gefilterd gebaseerd op een absolute log2 fold change ($|log2FC|$) van meer dan 1.5 en een gecorrigeerde p waarde (`padj`) van minder dan 0.05.

### **3.2 Betrokkenheid van B cel gerelateerde pathways**

Functionele verrijkingsanalyses gaven dieper inzicht in de biologische processen en pathway verstoringen:

* **Gene Ontology (GO) Termen:**
    De [GO analyse](results/Go-analyse.png) identificeerde significant verrijkte termen zoals **immunoglobulin complex**, **adaptive immune response** en **B cel mediated immuniteit**. Deze bevindingen onderstrepen de prominente rol van het immuunsysteem, en specifiek B cellen, bij RA.

* **KEGG Pathway Analyse: B cel Receptor Signaalroute en Rac**
    De [KEGG analyse](Resultaten/hsa04662.png) wees op de **B cel Receptor Signaalroute (hsa04662)** als significant verstoord. Binnen deze route voor B cel activatie werden genen zoals **BTK, BLNK en VAV 'upregulated'**. Echter, het gen **Rac** was significant **'downregulated'** met een log2 fold change van ongeveer -3. Deze specifieke 'downregulation' van Rac, te midden van de 'upregulation" van andere componenten in dezelfde pathway, suggereert een gerichte verstoring in de actin cytoskelet van B cellen.

## 4. Conclusie

De resultaten bevestigen verschillen in genexpressie tussen RA en gezonde personen. Velen zijn betrokken bij afweersysteem en ontstekingsreacties. GO analyse wees op verstoorde immuunrespons en cytokine activiteit bij reumapatiënten, wat duidt op een afwijkend immuunsysteem. De KEGG analyse benadrukt verstoringen in de B cel Receptor Signaalroute, met name de downregulation van Rac. Deze specifieke verstoring in Rac signalering kan leiden tot abnormale B cel functie zoals veranderde migratie of defecten in de immuunsynaps, wat bijdraagt aan de complexe pathogenese van RA. Concluderend geeft dit onderzoek inzicht in RA op moleculair niveau, waarbij het afweersysteem een grote rol speelt. Deze resultaten kunnen helpen bij het vinden van nieuwe medicijnen of biomarkers. 
