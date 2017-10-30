### About
This script will automatically add subclass name to the selected layers

This script is for Cadence Allegro software. Tested with Allegro 17.2

Created by Robert Feranec

(c) 2017 FEDEVEL, https://www.fedevel.com/academy

### Video
Here you can find a detailed video about how to create, run and use this script
[![Script GUI / Dialogue Form](https://user-images.githubusercontent.com/5564443/32172814-2574b7fa-bd3a-11e7-8bdf-52da990275c7.jpg)](https://www.youtube.com/watch?v=qY_MK-_1VWE)
### Screenshots
#### Script GUI / Dialogue Form
![Script GUI / Dialogue Form](https://user-images.githubusercontent.com/5564443/31919490-ad7a6e4c-b817-11e7-8d36-093c58fad0e2.png)
#### Before running the script
![Before running the script](https://user-images.githubusercontent.com/5564443/31919557-2c608476-b818-11e7-97d5-5552fb464f4c.png)
#### After running the script
Notice the added layer name in the bottom left corner
![After running the script - notice the added layer name in the bottom left corner](https://user-images.githubusercontent.com/5564443/31919566-355eb818-b818-11e7-8fa8-958385825828.png)
#### Detail of the automatically added layer name
![Detail of the automatically added layer name](https://user-images.githubusercontent.com/5564443/31919568-3da6e2b6-b818-11e7-9577-cf3b8a4caa70.png)

### Installation
To use this script, simply copy the files into your Cadence directory. For example, if your Cadence installation directory is d:\Cadence\SPB_17.2\ then:
* copy *add_layer_name.il* file into: d:\Cadence\SPB_17.2\share\local\pcb\skill\
* copy *add_layer_name.form* into d:\Cadence\SPB_17.2\share\local\pcb\forms\

### How to load the script
#### Automatically
If you would like to automatically load this script by your Allegro when it starts, do following:
1. Switch OFF Allegro
2. Go to: d:\Cadence\SPB_17.2\share\local\pcb\skill\
3. Copy *example.ilinit* into *allegro.ilinit*
4. Start Allegro

#### Manually (useful for debugging)
This is what you need to do to (re)load the script in the Allegro commad line:
1. go to skill command mode (only run this once, when you start your allegro):
```
skill
```
2. reload the script (do this every time you make any changes in the script)
```
load("add_layer_name.il")
```

### How to run the script
To start the script, run the following command in Cadence Allegro command line or in SKILL mode:
```
add_layer_name
```

### Documentation
Documentation which you may need when you are creating your own scripts or which you may need to understand the commands and features used in this script:
* Allegro skill documentation directory: d:\Cadence\SPB_17.2\doc\algroskill\
* Content of all Functions: file:///D:/Cadence/SPB_17.2/doc/algroskill/algroskillTOC.html
* Form Interface Functions: file:///D:/Cadence/SPB_17.2/doc/algroskill/11frmint.html
* SKILL Commands: Search on Internet for "Skill Language User Guide", e.g.: http://pwp.gatech.edu/wp-content/uploads/sites/367/2016/03/Intro_to_skill_prog.pdf

*Note: The absolute PATH depends on your Cadence installation.*

Examples to create your own scripts (very useful, especially the axlfrom.il) can be found here:
d:\Cadence\SPB_17.2\share\pcb\examples\skill\form\

### Note for me
Here is how to create software links under Windows 7

You have to start cmd as Administrator. Then run following commands:

```
mklink "d:\Cadence\SPB_17.2\share\local\pcb\forms\add_layer_name.form" "d:\Users\Robo\Code\allegro\scripts\add_layer_name\add_layer_name.form"
mklink "d:\Cadence\SPB_17.2\share\local\pcb\skill\add_layer_name.il" "d:\Users\Robo\Code\allegro\scripts\add_layer_name\add_layer_name.il"
```
