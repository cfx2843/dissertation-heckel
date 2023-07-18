//___________________________________________________________________________//
// TransiEnt Library, version: 2.0.0                 				         //
//                                                                           //
// Licensed by Hamburg University of Technology under Modelica License 2     //
// Copyright 2017, Hamburg University of Technology.                         //
//___________________________________________________________________________//
//                                                                           //
// TransiEnt.EE is a research project supported by the German Federal        //
// Ministry of Economics and Energy (FKZ 03ET4003).                          //
// The TransiEnt.EE research team consists of the following project partners://
// Institute of Engineering Thermodynamics (Hamburg University of Technology)//
// Institute of Energy Systems (Hamburg University of Technology),           //
// Institute of Electrical Power Systems and Automation                      //
// (Hamburg University of Technology),                                       //
// and is supported by                                                       //
// XRG Simulation GmbH (Hamburg, Germany).                                   //
//___________________________________________________________________________//


This ist the repository for the phd thesis of Jan-Peter Heckel. 
Title of phd thesis: Dynamische Modellierung der Sektorenkopplung zur Stabilitätsuntersuchung elektrischer Energiesysteme (in German language)
It works together with the TransiEnt Library. (https://github.com/TransiEnt-official/transient-lib)
  
Thank you for choosing the TransiEnt Library for your simulation purposes!
Please read the following steps for a successful usage.


Installation:
******************************

1. Copy the unzipped library files to your preferred folder

Currently, only Dymola provides full suppport of TransiEnt. The development team has tested all models carefully using Dymola 2017 and Dymola 2017 FD01.

2. Install External Precompiled Sources
---------------------------------------
Execute (as system administrator)
%path of the directory where the TransiEnt Library is located on your computer%\ClaRa 1.2.1\ClaRaDelay\update.bat
%path of the directory where the TransiEnt Library is located on your computer%\ClaRa 1.2.1\TILMedia 1.2.1 ClaRa\update.bat

→ this will copy some external libraries to your system which are necessary for using a ClaRa internal implementation of signal delay and for using external media data from TIL Media.

3. Open the Library using a MOS Script
----------------------------------------
In order to use the TransiEnt Library a few external libraries have to be loaded and some modelica environment variables have to be set. You can perform all required steps automatically by running the script loadTransiEnt.mos located in this directory.

Before doing this, you have to replace "ADD_YOUR_PATH_TO_DIRECTORY_HERE" (Line 2 of loadTransiEnt.mos) with the absolute path to the directory where the Repositores is located. Line 2 should look something like the following (use front slashes):

repopath="d:/ModelicaLibraries/TransiEnt";

Furthermore, you should replace "ADD_YOUR_PATH_FOR_RESULTS_HERE" (Line 3 of loadTransiEnt.mos)  with the absolute path to the directory where you want to save your results. This enables you to call the functions named 'plotResults' in the Examples and Testers of the Library which will show you some relevant simulation results. Line 3 should look something like this (use front slashes):

resultpath="c:/simulationsresults";

Please make sure that this directory exists (will not be created automatically).

The libraries required and automatically loaded by the script are the following:
* TransiEnt ("Simulation of coupled energy networks")
* ClaRa ("Simulation fo Clausius Rankine Cycles")
* TILMedia (for the calculation of media data)
* FluidDissipation (for the calculation of heat transfer coefficients and pressure losses)

The script can be called from dymola by Simulation -> Simulation -> Script -> RunScript

Alternatively you can add the script to your dymola.mos to load TransiEnt automatically every time dymola is started. The dymola.mos is located in $DYMOLA_INSTALLATION_FOLDER$/insert/dymola.mos. The required line would look like this:

RunScript("d:/ModelicaLibraries/TransiEnt/loadWorkspace.mos")
	
Contact:	
******************************
	transientlibrary@tuhh.de
	
******************************
------------------------------------
******************************
	
Deutschsprachige Informationen zu den Daten:

1.) Titel des Forschungsdatensatzes bzw. der Software-Resourcen: Datensatz für die Dissertation von Jan-Peter Heckel mit dem Titel "Dynamische Modellierung der Sektorenkopplung zur Stabilitätsuntersuchung elektrischer Energiesysteme" (2023)

2.) Verantwortlicher: Jan-Peter Heckel, Technische Universität Hamburg, Institut für Elektrische Energietechnik, jan.heckel@tuhh.de, ORCiD: 0000-0003-0249-7789

3.) Kontext des Datensatzes: Der Datensatz ist im Rahmen der Dissertation von Herrn Jan-Peter Heckel entstanden. Die Dissertation enstand im Rahmen des Projektes ResiliEntEE (Förderkennzeichen: 03ET4048).
Projekthintergrund und Ergebnisse:

Im Projekt wird in einem interdisziplinären Ansatz untersucht, wie man die
Resilienz eines gekoppelten Energiesystems mit formal belastbaren Aussagen
auswerten kann. Mit der Resilienz eines Energiesystems ist die Fähigkeit
gemeint, nach einer Störung die Funktion aufrecht zu erhalten und nach
einer Störung in einen zulässigen Betriebszustand zurückzukehren. Damit
kann die Zuverlässigkeit eines Energiesystems neben Kriterien wie der Wirtschaftlichkeit
und der Umweltverträglichkeit mit in die Betrachtung einbezogen
werden. Im Projekt wurden Szenarien mit unterschiedlichen Durchdringungen
erneuerbarer Energien, unterschiedlichen Störungen, unterschiedlichen
Gaszusammensetzungen und unterschiedlichen Ausbaustufen des elektrischen
Netzes untersucht. Bestandteil waren nationale Energiesysteme von
Deutschland mit Fokus auf Norddeutschland. Auf Grund der Ausdehnung
dieses Energiesystems sind Verfahren zur Modellaggregation bzw. Reduktion
notwendig.
Dabei konnte gezeigt werden, dass eine Energiesystemanalyse nationaler
und sektorengekoppelter Systeme mittels dynamischer Simulation möglich ist
und eine aussagekräftige Modellierung erlaubt. Im Rahmen der gewählten
Modellierung konnte nachgewiesen werden, dass ein solches Energiesystem
einen sicheren und resilienten Betrieb ermöglicht. Darüber hinaus hat sich
gezeigt, dass Konzepte, die in der Literatur zur Resilienzsteigerung vorgeschlagen
werden, die Resilienz in den Sektoren, in denen sie eingesetzt
werden, erhöhen können. Es ergab sich aber auch, dass diese zu Resilienzverringerungen
in anderen Sektoren führen können. Bei diesen Konzepten
handelt es sich um die Dispersion, d. h. die Verteilung von Anlagen über
das Netz und somit der Ersatz von großen Anlagen durch mehrere kleine,
die Diversität, d. h. der Einsatz von unterschiedlichen Technologien bzw.
eines Technologiemixes, und die Erhöhung von Speicherkapazitäten. Diese
Konzepte basieren auf dem Thema der Redundanz, sodass bei Ausfall einer
Anlage bzw. Technologie eine andere die Aufgabe übernehmen kann.

4.) Verwendete Software: 

-Dymola, Modelica, TransiEnt Library (siehe oben)
-Matlab R2021b für die *.m-Skripte und *.-mat-Datensätze

Verwendete externe/sekundäre Datensätze und Dokumente:

-Datensätze aus der TransiEnt Library: Technische Universität Hamburg, TransiEnt Library, Version 2.0.0, elektronische
Quelle, abgerufen am 17.02.2023, 2021. Adresse: https :
//www.tuhh.de/transient-ee/
A. Senkel, C. Bode, J.-P. Heckel, O. Schülting, G. Schmitz, A. Kather
und C. Becker, “Status of the TransiEnt Library: Transient Simulation
of Complex Integrated Energy Systems,” in 14th International Modelica
Conference, Linköping, 2021. DOI: 10.3384/ecp21181187

-ENTSO-E Testszenario: ENTSO-E, DOCUMENTATION ON CONTROLLER TESTS IN TEST
GRID CONFIGURATIONS, elektronische Quelle, abgerufen am
17.02.2023, Brüssel, 2013. Adresse: https://eepublicdownloads.
entsoe.eu/clean-documents/pre2015/publications/entsoe/RG_
SOC_CE/131127_Controller_Test_Report.pdf

-SimBench: S. Meinecke, S. Drauz, A. Kletke, D. Sarajli´cet und et. al., Sim-
Bench – Dokumentation: Dokumentationsversion DE-1.0.0: Elektrische
Benchmarknetzmodelle, elektronische Quelle, abgerufen am
04.08.2021, Kassel, 2019. Adresse: https : / / simbench . de / wp -
content/uploads/2019/08/simbench_documentation_de.pdf.

Die Dokumetionen der einzelnen Dateien und die der TransiEnt Library sind zu beachten.

Für weitere Quellen ist das Literaturverzeichnis der Dissertation zu beachten.

5.) Struktur: Die Struktur der Daten und Software entspricht derer der Dissertation gemäß der Kapitel. Dieser Datensatz und die Software stellt den Anhang der Dissertation dar. Somit ist eine Reproduzierbarkeit der Ergebnisse gewährleistet. 

6.) Qualitätsmaßnahmen: Zur Validierung siehe Dissertation Kapitel 3.6

7.) Datenversionen/ Versionsverlauf: Version zur Einreichung und Veröffentlichung der Dissertation v1.0 und v2.0 (Readme angepasst)

8.) Freier Zugang, offene Lizenz: BSD 3-Clause License