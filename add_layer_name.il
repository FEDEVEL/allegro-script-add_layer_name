;--------------------------------------------------------------------
;This script will automatically add subclass name to the selected layers
;This script is for Cadence Allegro software. Tested with Allegro 17.2
;Created by Robert Feranec
;(c) 2017 FEDEVEL, https://www.fedevel.com/academy
;
;Download the script: https://github.com/FEDEVEL/allegro-script-add_layer_name
;--------------------------------------------------------------------

;Location of this file
;If your Cadence installation directory is d:\Cadence\SPB_17.2\
;then copy this file into: d:\Cadence\SPB_17.2\share\local\pcb\skill\
;IMPORTANT: Do not forget. This script also requires add_layer_name.form file. 

;How to load the script
;This is what you need to do to (re)load the script in the Allegro commad line:
;1) go to skill command mode (only run this once, when you start your allegro):
;skill
;2) reload the script
;load("add_layer_name.il")

;How to run the script
;1) Run following command in Cadence Allegro command line:
;add_layer_name

;Documentation
;Documentation which you may need to create your own scripts or understand the commands and features used here:
;Note: The absolute PATH depends on your Cadence installation.
;Allegro skill documentation directory: d:\Cadence\SPB_17.2\doc\algroskill\
;Content of all Functions: file:///D:/Cadence/SPB_17.2/doc/algroskill/algroskillTOC.html
;Form Interface Functions: file:///D:/Cadence/SPB_17.2/doc/algroskill/11frmint.html
;SKILL Commands: Search on Internet for "Skill Language User Guide", e.g.: http://pwp.gatech.edu/wp-content/uploads/sites/367/2016/03/Intro_to_skill_prog.pdf

;Examples to create your own scripts (very useful, especially the axlfrom.il)
;d:\Cadence\SPB_17.2\share\pcb\examples\skill\form\

;NOTE
;If you would like to automatically load this script by your Allegro when it starts, do following:
;1) Go to: d:\Cadence\SPB_17.2\share\local\pcb\skill\
;2) Copy "example.ilinit" into "allegro.ilinit"
;3) Copy "add_layer_name.il" to d:\Cadence\SPB_17.2\share\local\pcb\skill\
;4) Copy "add_layer_name.form" to d:\Cadence\SPB_17.2\share\local\pcb\forms\

;----------------------------- THE SCRIPT ---------------------------------------

;Print a note in Allegro commadn line when this script is loaded
print "Loading add_layer_name. Created by Robert Feranec (c) 2017 FEDEVEL" 

;register this command, so we can start it from Allegro command line
axlCmdRegister( "add_layer_name" `add_layer_name)

;When anything happen in our form, this function is called (e.g when you do any chages in the form or when you press button)
(defun _afAddLayerNameCallback (fw)
	(prog (t1 item field cnt)
	 
		if((fw->doneState == 1)  then ;we pressed our done button Note: 0 = action; 1 = done; 2 = cancel; 3 = abort, more info at file:///D:/Cadence/SPB_17.2/doc/algroskill/11frmint.html#428663
			
			axlUIWPrint(nil "Adding layer names ...") ;console printing
			
			;prepare position where the text will be added (the position is stored in list of floating x and y)
			position_list = '() ; create an empy list
			position_x = atof(axlFormGetField(fw "text_position_x")) ;get the x position and convert string to float
			position_y = atof(axlFormGetField(fw "text_position_y")) ;get the y position and convert string to float
			position_list = cons(position_y position_list) ;add x to the list
			position_list = cons(position_x position_list) ;add y to the list
			
			;TOP Layers (text is not mirrored)
			selected_layers = axlFormListGetSelItems(fw "subclass_top") ;get all the layers selected in subclass_top list
			myorient = make_axlTextOrientation(?textBlock axlFormGetField(fw "font_size"), ?rotation 0.0,?mirrored nil, ?justify "left") ;set the text property			
			
			foreach(selected_layer selected_layers ;go through every selected layer in subclass_top list
				axlDBCreateText( selected_layer, position_list, myorient, strcat("manufacturing/" selected_layer), nil) ; add the subclass name to the layer
			)
			
			;BOTTOM Layers (text is mirrored)
			selected_layers = axlFormListGetSelItems(fw "subclass_bottom") ;get all the layers selected in subclass_bottom list
			myorient = make_axlTextOrientation(?textBlock axlFormGetField(fw "font_size"), ?rotation 0.0,?mirrored t, ?justify "right") ;set the text property			
			
			foreach(selected_layer selected_layers ;go through every selected layer in subclass_bottom list
				axlDBCreateText( selected_layer, position_list, myorient, strcat("manufacturing/" selected_layer), nil) ; add the subclass name to the layer
			)						

			axlUIWPrint(nil "Done") ;console printing
			axlFormClose(fw)
		)
		return()
	)
)

;-------------------------------------
;Definition of add_layer_name command
;-------------------------------------
procedure( add_layer_name()
	;define constants
	TOP_VARIANT_NAME_SUBSTRING = "VARIANT_T"
	BOTTOM_VARIANT_NAME_SUBSCTRING = "VARIANT_B"
	DEFAULT_TEXT_BLOCK_NAME = "Standard"
	DEFAULT_CLASS = "MANUFACTURING"
	DEFAULT_TEXT_POSITION = "0:-2"
	VERSION = "Version 0.1"
	
	axlUIWPrint(nil "Starting add_layer_name script.") ;console printing
	
	;create the form
	fw = axlFormCreate( (gensym) "add_layer_name.form" nil '_afAddLayerNameCallback t nil)
	
	;NOTE: this is currently hardcoded for "MANUFACTURING" class, but if people are interested, a class selection drop down box can be added in new script version
	variants = axlSubclasses( axlMapClassName(DEFAULT_CLASS)) ;get list of all subclasses in MANUFACTURING class
	
	;prepare and pre-select TOP
	axlFormSetField(fw "subclass_top" variants) ;fill up TOP list with all the subclasses
	foreach(variant variants ;go through the list and pre-select all layers which contain variant substring e.g. if there is "VARIANT_T" in subclass name
		if(rexMatchp(TOP_VARIANT_NAME_SUBSTRING variant)==t then 
			axlFormListSelect(fw "subclass_top" variant)
		)
	)
	
	;prepare and pre-select BOTTOM
	axlFormSetField(fw "subclass_bottom" variants) ;fill up BOTTOM list with all the subclasses
	foreach(variant variants ;go through the list and pre-select all layers which contain variant substring e.g. if there is "VARIANT_B" in subclass name
		if(rexMatchp(BOTTOM_VARIANT_NAME_SUBSCTRING variant)==t then 
			axlFormListSelect(fw "subclass_bottom" variant)
		)
	)

	;prepare some variables
	numTextBlocks = axlDBGetTextBlockCount() ;get number of all text box sizes
	text_sizes_list = '() ;we are going to prepare list of all text sizes
	preselected_text_size = "" ; default text size
	
	;prepare list of all the available text boxes (list of all available fonts)
	i = numTextBlocks	
	while( i > 0
		
		;"cons", the compand which we will be using later, doesnt like "nil", so if font name is empty, set it to " "
		text_name = axlDBTextBlockGetName(i) ;based on text block number, get name of the font
		if(text_name==nil then
			text_name = " "
		)
		
		;create a temporary list with block number/name and its position. It will look like ("#1 Name" "i")
		tmp_list = '() 
		tmp_list = cons(sprintf(nil "%d" i) tmp_list)
		tmp_list = cons(sprintf(nil "#%d %s" i text_name) tmp_list);build the list, looks like ("#1 Name" "i")	
		
		;now, add this tempary list into our main list with the text sizes
		text_sizes_list = cons(tmp_list text_sizes_list) ;the list will look like ("#1 Name" "1")("#2 Name" "2") ...
		
		;remember the default font position in the list, it will be pre-selected later
		if(text_name==DEFAULT_TEXT_BLOCK_NAME then
			preselected_text_size = sprintf(nil "%d" i)
		)		
		i--
	) 
	;axlUIWPrint(nil sprintf(nil "%L" text_sizes_list)) ;console printing, just an example how to print list .. in case we need it :)
	
	;fill up and preselect font sizes
	axlFormBuildPopup(fw "fontsizes" text_sizes_list ) ; update list of text sizes
	axlFormSetField(fw "font_size" preselected_text_size ) ; pre-select the text size
	
	;default text position	
	axlFormSetField(fw "text_position_x" "0" )
	axlFormSetField(fw "text_position_y" "-2" )
	
	;display the form
	axlFormDisplay(fw)
	
	axlUIWPrint(fw VERSION) ;Write into the status bar of the form, add there version info	
)