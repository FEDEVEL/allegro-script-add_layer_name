### About
This script will automatically add subclass name to the selected layers

This script is for Cadence Allegro software. Tested with Allegro 17.2

Created by Robert Feranec

(c) 2017 FEDEVEL, https://www.fedevel.com/academy


### Location of this files
If your Cadence installation directory is d:\Cadence\SPB_17.2\
* then copy *add_layer_name.il* file into: d:\Cadence\SPB_17.2\share\local\pcb\skill\
* and copy *add_layer_name.form* into d:\Cadence\SPB_17.2\share\local\pcb\forms\

### How to load the script
This is what you need to do to (re)load the script in the Allegro commad line:
1. go to skill command mode (only run this once, when you start your allegro):
```
skill
```
2. reload the script
```
load("add_layer_name.il")
```

### How to run the script
1. Run following command in Cadence Allegro command line:
```
add_layer_name
```

### Documentation
Documentation which you may need to create your own scripts or understand the commands and features used here.

*Note: The absolute PATH depends on your Cadence installation.*
* Allegro skill documentation directory: d:\Cadence\SPB_17.2\doc\algroskill\
* Content of all Functions: file:///D:/Cadence/SPB_17.2/doc/algroskill/algroskillTOC.html
* Form Interface Functions: file:///D:/Cadence/SPB_17.2/doc/algroskill/11frmint.html
* SKILL Commands: Search on Internet for "Skill Language User Guide", e.g.: http://pwp.gatech.edu/wp-content/uploads/sites/367/2016/03/Intro_to_skill_prog.pdf

Examples to create your own scripts (very useful, especially the axlfrom.il)
d:\Cadence\SPB_17.2\share\pcb\examples\skill\form\

### NOTE
If you would like to automatically load this script by your Allegro when it starts, do following:
1. Go to: d:\Cadence\SPB_17.2\share\local\pcb\skill\
2. Copy *example.ilinit* into *allegro.ilinit*
3. Copy *add_layer_name.il* to d:\Cadence\SPB_17.2\share\local\pcb\skill\
4. Copy *add_layer_name.form* to d:\Cadence\SPB_17.2\share\local\pcb\forms\
