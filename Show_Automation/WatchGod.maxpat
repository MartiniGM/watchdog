{
	"patcher" : 	{
		"fileversion" : 1,
		"appversion" : 		{
			"major" : 7,
			"minor" : 0,
			"revision" : 6,
			"architecture" : "x86",
			"modernui" : 1
		}
,
		"rect" : [ 50.0, 45.0, 1601.0, 967.0 ],
		"bgcolor" : [ 224.0, 224.0, 219.0, 1.0 ],
		"bglocked" : 0,
		"openinpresentation" : 1,
		"default_fontsize" : 12.0,
		"default_fontface" : 0,
		"default_fontname" : "Arial",
		"gridonopen" : 1,
		"gridsize" : [ 15.0, 15.0 ],
		"gridsnaponopen" : 1,
		"objectsnaponopen" : 1,
		"statusbarvisible" : 2,
		"toolbarvisible" : 1,
		"lefttoolbarpinned" : 0,
		"toptoolbarpinned" : 0,
		"righttoolbarpinned" : 0,
		"bottomtoolbarpinned" : 0,
		"toolbars_unpinned_last_save" : 2,
		"tallnewobj" : 0,
		"boxanimatetime" : 200,
		"enablehscroll" : 1,
		"enablevscroll" : 1,
		"devicewidth" : 0.0,
		"description" : "",
		"digest" : "",
		"tags" : "",
		"style" : "",
		"subpatcher_template" : "",
		"boxes" : [ 			{
				"box" : 				{
					"args" : [ "10.42.21.82" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.21.82",
					"id" : "obj-96",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 807.0, 430.5, 165.5, 21.5 ],
					"presentation" : 1,
					"presentation_rect" : [ 593.0, 391.0, 155.0, 14.0 ],
					"varname" : "pi10422182",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-113",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"patching_rect" : [ 971.0, 1280.0, 100.0, 22.0 ],
					"style" : "",
					"text" : "t b"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-107",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 971.0, 1250.0, 208.0, 22.0 ],
					"style" : "",
					"text" : "r start_stop_finished_msg"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-97",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"patching_rect" : [ 971.0, 1381.0, 35.0, 22.0 ],
					"style" : "",
					"text" : "shell"
				}

			}
, 			{
				"box" : 				{
					"fontface" : 0,
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-105",
					"linecount" : 4,
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 971.0, 1313.0, 306.0, 62.0 ],
					"style" : "",
					"text" : "sprintf osascript -e 'tell application \\\\\\\"Max\\\\\\\"' -e 'return button returned of (display dialog \\\\\\\"Start/Stop Script Completed!\\\\\\\" with title \\\\\\\"Start/Stop Completed\\\\\\\" buttons {\\\\\\\"OK\\\\\\\"} default button \\\\\\\"OK\\\\\\\")' -e 'end tell'"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-103",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 1474.0, 791.5, 100.0, 22.0 ],
					"style" : "",
					"text" : "checkNVR"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-101",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"patching_rect" : [ 1474.0, 699.0, 100.0, 22.0 ],
					"style" : "",
					"text" : "loadbang"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-98",
					"maxclass" : "toggle",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "int" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1474.0, 731.5, 24.0, 24.0 ],
					"style" : ""
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-94",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"patching_rect" : [ 1474.0, 764.0, 100.0, 22.0 ],
					"style" : "",
					"text" : "metro 00:10:00"
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.24.86" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.24.86",
					"id" : "obj-42",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 566.75, 249.0, 133.5, 15.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 502.25, 237.0, 162.5, 15.0 ],
					"varname" : "pi10422486",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-92",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 679.0, -34.0, 100.0, 22.0 ],
					"style" : "",
					"text" : "s showAllAreas"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-91",
					"maxclass" : "textbutton",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "", "", "int" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 449.0, -34.0, 223.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 531.0, -35.0, 221.0, 20.0 ],
					"style" : "",
					"text" : "Show All Areas",
					"varname" : "showAll"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-80",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 1005.0, 49.5, 50.0, 22.0 ],
					"style" : "",
					"text" : "18"
				}

			}
, 			{
				"box" : 				{
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 1,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"id" : "obj-85",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "areaStatus.maxpat",
					"numinlets" : 23,
					"numoutlets" : 24,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "" ],
					"patching_rect" : [ 902.0, -23.0, 337.0, 45.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 876.0, 155.0, 45.0, 40.0 ],
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-78",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 723.0, 505.0, 50.0, 22.0 ],
					"style" : "",
					"text" : "20"
				}

			}
, 			{
				"box" : 				{
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 1,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"id" : "obj-79",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "areaStatus.maxpat",
					"numinlets" : 23,
					"numoutlets" : 24,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "" ],
					"patching_rect" : [ 598.25, 331.0, 489.0, 50.5 ],
					"presentation" : 1,
					"presentation_rect" : [ 826.0, 309.0, 45.0, 40.0 ],
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-76",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 372.652161, 21.0, 50.0, 22.0 ],
					"style" : "",
					"text" : "11"
				}

			}
, 			{
				"box" : 				{
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 1,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"id" : "obj-77",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "areaStatus.maxpat",
					"numinlets" : 23,
					"numoutlets" : 24,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "" ],
					"patching_rect" : [ 427.32608, 31.25, 291.347839, 75.25 ],
					"presentation" : 1,
					"presentation_rect" : [ 518.0, 120.0, 40.5, 37.5 ],
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-74",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 343.0, 412.0, 50.0, 22.0 ],
					"style" : "",
					"text" : "19"
				}

			}
, 			{
				"box" : 				{
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 1,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"id" : "obj-75",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "areaStatus.maxpat",
					"numinlets" : 23,
					"numoutlets" : 24,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "" ],
					"patching_rect" : [ 449.0, 446.0, 365.347839, 46.5 ],
					"presentation" : 1,
					"presentation_rect" : [ 589.125, 497.0, 45.0, 40.0 ],
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-69",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 895.5, 579.0, 50.0, 22.0 ],
					"style" : "",
					"text" : "16"
				}

			}
, 			{
				"box" : 				{
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 1,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"id" : "obj-73",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "areaStatus.maxpat",
					"numinlets" : 23,
					"numoutlets" : 24,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "" ],
					"patching_rect" : [ 1012.5, 575.0, 198.0, 51.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 883.0, 661.0, 45.0, 40.0 ],
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-65",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 278.5, 102.0, 50.0, 22.0 ],
					"style" : "",
					"text" : "11"
				}

			}
, 			{
				"box" : 				{
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 1,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"id" : "obj-64",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "areaStatus.maxpat",
					"numinlets" : 23,
					"numoutlets" : 24,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "" ],
					"patching_rect" : [ 329.0, 130.5, 183.0, 56.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 315.0, 323.0, 40.5, 37.5 ],
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-61",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 467.0, 744.0, 50.0, 22.0 ],
					"style" : "",
					"text" : "7"
				}

			}
, 			{
				"box" : 				{
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 1,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"id" : "obj-57",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "areaStatus.maxpat",
					"numinlets" : 23,
					"numoutlets" : 24,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "" ],
					"patching_rect" : [ 519.0, 715.0, 198.0, 51.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 559.0, 739.0, 45.0, 40.0 ],
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-54",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 224.0, 654.0, 50.0, 22.0 ],
					"style" : "",
					"text" : "15"
				}

			}
, 			{
				"box" : 				{
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 1,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"id" : "obj-53",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "areaStatus.maxpat",
					"numinlets" : 23,
					"numoutlets" : 24,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "" ],
					"patching_rect" : [ 281.090912, 670.5, 198.0, 51.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 329.0, 574.0, 45.0, 40.0 ],
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-52",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 70.5, 614.0, 50.0, 22.0 ],
					"style" : "",
					"text" : "10"
				}

			}
, 			{
				"box" : 				{
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 1,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"id" : "obj-50",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "areaStatus.maxpat",
					"numinlets" : 23,
					"numoutlets" : 24,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "" ],
					"patching_rect" : [ 66.5, 647.5, 197.5, 51.5 ],
					"presentation" : 1,
					"presentation_rect" : [ 89.0, 730.5, 40.5, 37.5 ],
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-43",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 102.5, 164.5, 50.0, 22.0 ],
					"style" : "",
					"text" : "8"
				}

			}
, 			{
				"box" : 				{
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 1,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"id" : "obj-32",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "areaStatus.maxpat",
					"numinlets" : 23,
					"numoutlets" : 24,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "" ],
					"patching_rect" : [ 102.5, 196.0, 123.5, 79.5 ],
					"presentation" : 1,
					"presentation_rect" : [ 155.0, 228.0, 40.5, 37.5 ],
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-41",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"patching_rect" : [ 224.0, 1286.0, 100.0, 22.0 ],
					"style" : "",
					"text" : "loadbang"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-40",
					"linecount" : 2,
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 224.0, 1317.5, 244.0, 35.0 ],
					"style" : "",
					"text" : ";\rmax setmirrortoconsole 1"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-49",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 0,
					"patching_rect" : [ 794.5, 1270.5, 100.0, 22.0 ],
					"style" : "",
					"text" : "wakeMacOS"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-48",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 965.0, 1216.0, 153.0, 22.0 ],
					"style" : "",
					"text" : "r wake_entertainment_msg"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-47",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 835.0, 1216.0, 118.0, 22.0 ],
					"style" : "",
					"text" : "r wake_global_msg"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-44",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 701.0, 1216.0, 118.0, 22.0 ],
					"style" : "",
					"text" : "r wake_nicolae_msg"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-39",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 293.5, 1110.0, 116.0, 22.0 ],
					"style" : "",
					"text" : "r start_lycra_msg"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-37",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 293.5, 1130.0, 150.0, 20.0 ],
					"style" : "",
					"text" : "starts lycratunnel"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-29",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"patching_rect" : [ 262.0, 1178.0, 100.0, 22.0 ],
					"style" : "",
					"text" : "delay 100"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-28",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 343.0, 1206.0, 50.0, 22.0 ],
					"style" : "",
					"text" : "1"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-9",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 262.0, 1206.0, 50.0, 22.0 ],
					"style" : "",
					"text" : "0"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-13",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "bang", "bang" ],
					"patching_rect" : [ 262.0, 1152.0, 100.0, 22.0 ],
					"style" : "",
					"text" : "t b b"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-16",
					"maxclass" : "button",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"patching_rect" : [ 262.0, 1110.0, 24.0, 24.0 ],
					"style" : ""
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-20",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 262.0, 1234.0, 100.0, 22.0 ],
					"style" : "",
					"text" : "prepend /show"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-26",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 262.0, 1262.0, 181.5, 22.0 ],
					"style" : "",
					"text" : "udpsend 10.42.22.20 10000"
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.96.56" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.96.56",
					"id" : "obj-7",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 777.0, 5.0, 118.0, 15.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 899.25, 5.0, 118.0, 15.0 ],
					"varname" : "pi10429656",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.17.11" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.17.11",
					"id" : "obj-24",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 982.0, 430.5, 177.0, 11.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 967.5, 415.0, 174.5, 15.0 ],
					"varname" : "pi10421711",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-23",
					"linecount" : 3,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 1442.0, 330.0, 150.0, 47.0 ],
					"presentation" : 1,
					"presentation_linecount" : 2,
					"presentation_rect" : [ 1369.0, 337.0, 184.0, 33.0 ],
					"style" : "",
					"text" : "this refreshes global, use this to get rid of fuzzy-ness"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-22",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 1427.0, 315.0, 150.0, 33.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1369.0, 307.5, 184.0, 20.0 ],
					"style" : "",
					"text" : "use this to start global if it's off"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-18",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 1432.5, 176.0, 117.0, 22.0 ],
					"style" : "",
					"text" : "/global/refresh"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-17",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 1417.0, 209.0, 117.0, 22.0 ],
					"style" : "",
					"text" : "/global/start"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-12",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 1417.0, 244.0, 203.0, 22.0 ],
					"style" : "",
					"text" : "udpsend 10.42.21.18 9998"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-11",
					"maxclass" : "textbutton",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "", "", "int" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1308.0, 218.0, 100.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1254.0, 341.0, 100.0, 20.0 ],
					"style" : "",
					"text" : "Global-Refresh",
					"texton" : ""
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-8",
					"maxclass" : "textbutton",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "", "", "int" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1308.0, 163.0, 100.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1254.0, 312.0, 100.0, 20.0 ],
					"style" : "",
					"text" : "Global-Start",
					"texton" : ""
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.21.91" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.21.91",
					"id" : "obj-38",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 497.0, 621.0, 152.0, 13.5 ],
					"presentation" : 1,
					"presentation_rect" : [ 465.5, 597.0, 117.0, 12.0 ],
					"varname" : "pi10422191",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.21.81" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.21.81",
					"id" : "obj-35",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 482.0, 606.0, 152.0, 13.5 ],
					"presentation" : 1,
					"presentation_rect" : [ 465.5, 561.5, 117.0, 12.0 ],
					"varname" : "pi10422181",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.17.43" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.17.43",
					"id" : "obj-30",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 1086.0, 446.0, 120.0, 15.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 994.0, 517.0, 90.0, 15.0 ],
					"varname" : "pi10421743",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-15",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"patching_rect" : [ 622.0, 1033.0, 69.0, 22.0 ],
					"save" : [ "#N", "thispatcher", ";", "#Q", "end", ";" ],
					"style" : "",
					"text" : "thispatcher"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-10",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"patching_rect" : [ 474.5, 1033.0, 69.0, 22.0 ],
					"save" : [ "#N", "thispatcher", ";", "#Q", "end", ";" ],
					"style" : "",
					"text" : "thispatcher"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-4",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 622.0, 997.5, 100.0, 22.0 ],
					"style" : "",
					"text" : "blinkBGRed"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-6",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 622.0, 968.0, 119.0, 22.0 ],
					"style" : "",
					"text" : "r stop_show_msg"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-2",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 474.5, 997.5, 100.0, 22.0 ],
					"style" : "",
					"text" : "blinkBGGreen"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-1",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 474.5, 968.0, 119.0, 22.0 ],
					"style" : "",
					"text" : "r start_show_msg"
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.23.41" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.23.41",
					"id" : "obj-405",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 566.75, 235.75, 171.25, 13.5 ],
					"presentation" : 1,
					"presentation_rect" : [ 502.25, 200.5, 96.5, 15.0 ],
					"varname" : "pi10422341",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-395",
					"linecount" : 2,
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 81.5, 984.5, 100.0, 35.0 ],
					"style" : "",
					"text" : "r concert_off_msg"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-396",
					"linecount" : 2,
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 293.5, 990.0, 100.0, 35.0 ],
					"style" : "",
					"text" : "r concert_on_msg"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-397",
					"maxclass" : "toggle",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "int" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 232.5, 995.5, 24.0, 24.0 ],
					"style" : ""
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-398",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"patching_rect" : [ 232.5, 1056.5, 69.0, 22.0 ],
					"save" : [ "#N", "thispatcher", ";", "#Q", "end", ";" ],
					"style" : "",
					"text" : "thispatcher"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-399",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 232.5, 1032.5, 186.0, 22.0 ],
					"style" : "",
					"text" : "script send venueMode alpha 0.3"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-400",
					"maxclass" : "toggle",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "int" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 13.5, 995.5, 24.0, 24.0 ],
					"style" : ""
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-401",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 13.5, 1032.5, 184.0, 22.0 ],
					"style" : "",
					"text" : "script send venueMode alpha 0"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-403",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"patching_rect" : [ 13.5, 1056.5, 69.0, 22.0 ],
					"save" : [ "#N", "thispatcher", ";", "#Q", "end", ";" ],
					"style" : "",
					"text" : "thispatcher"
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.22.49" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.22.49",
					"id" : "obj-394",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 465.5, 515.0, 241.0, 12.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 423.0, 499.5, 148.0, 12.5 ],
					"varname" : "pi10422249",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-371",
					"linecount" : 3,
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 1094.0, 941.0, 50.0, 49.0 ],
					"style" : "",
					"text" : "symbol <password>"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-382",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "bang", "" ],
					"patching_rect" : [ 1094.0, 1023.5, 100.0, 22.0 ],
					"style" : "",
					"text" : "sel \"000\""
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-383",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"patching_rect" : [ 1094.0, 997.5, 100.0, 22.0 ],
					"style" : "",
					"text" : "dialog password:"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-386",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 983.0, 1062.5, 120.0, 22.0 ],
					"style" : "",
					"text" : "piVolumes"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-388",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 983.0, 1008.0, 50.0, 22.0 ],
					"style" : "",
					"text" : "open"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-390",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 983.0, 1033.0, 100.0, 22.0 ],
					"style" : "",
					"text" : "pcontrol"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-391",
					"maxclass" : "textbutton",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "", "", "int" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 983.0, 900.5, 196.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1240.0, 559.0, 221.0, 20.0 ],
					"style" : "",
					"text" : "Open Pi Volume Screen",
					"varname" : "poeoff[6]"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-331",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 0,
					"patching_rect" : [ 1303.0, 518.0, 112.0, 22.0 ],
					"style" : "",
					"text" : "volumeReadback"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-368",
					"linecount" : 3,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 1166.0, 1124.0, 150.0, 47.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1233.5, 617.0, 353.0, 20.0 ],
					"style" : "",
					"text" : "enter password to send Play to Ableton on media servers"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-315",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 1319.0, 1139.5, 120.0, 22.0 ],
					"style" : "",
					"text" : "sendPlayToAbleton"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-330",
					"maxclass" : "textbutton",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "", "", "int" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1319.0, 1112.0, 223.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1236.75, 597.0, 221.0, 20.0 ],
					"style" : "",
					"text" : "Send Play To Ableton",
					"varname" : "poeoff[4]"
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.17.20" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.17.20",
					"id" : "obj-393",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 852.5, 475.0, 120.0, 15.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 826.0, 466.0, 120.0, 15.0 ],
					"varname" : "pi10421720",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-389",
					"linecount" : 4,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 1166.0, 1049.5, 151.0, 60.0 ],
					"style" : "",
					"text" : "enter password to restart POD.\nPOD health improves with daily restarts!"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-384",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 1319.0, 1077.0, 120.0, 22.0 ],
					"style" : "",
					"text" : "restartPOD"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-387",
					"maxclass" : "textbutton",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "", "", "int" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1319.0, 1049.5, 223.0, 22.0 ],
					"style" : "",
					"text" : "Restart POD (plant robot by TV Arch)",
					"varname" : "poeoff[3]"
				}

			}
, 			{
				"box" : 				{
					"fontsize" : 9.0,
					"id" : "obj-369",
					"linecount" : 4,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 1011.0, 79.0, 140.0, 47.0 ],
					"style" : "",
					"text" : "note: this Cave Crystals arduino is not on PoE, you must go to the Caves nook and reset it manually"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-309",
					"linecount" : 3,
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 1467.0, 323.0, 50.0, 49.0 ],
					"style" : "",
					"text" : "symbol <password>"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-364",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "bang", "" ],
					"patching_rect" : [ 1467.0, 405.5, 100.0, 22.0 ],
					"style" : "",
					"text" : "sel \"000\""
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-366",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"patching_rect" : [ 1467.0, 379.5, 100.0, 22.0 ],
					"style" : "",
					"text" : "dialog password:"
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.30.99" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.30.99",
					"id" : "obj-381",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 497.0, 638.0, 110.0, 12.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 480.5, 614.0, 106.5, 15.0 ],
					"varname" : "pi10423099",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.17.46" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.17.46",
					"id" : "obj-378",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 1086.0, 331.0, 161.0, 15.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1072.0, 334.25, 167.0, 15.0 ],
					"varname" : "pi10421746",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.17.45" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.17.45",
					"id" : "obj-376",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 1086.0, 304.5, 161.0, 15.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1072.0, 312.0, 161.0, 15.0 ],
					"varname" : "pi10421745",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-374",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 0,
					"patching_rect" : [ 1303.0, 549.5, 128.0, 22.0 ],
					"style" : "",
					"text" : "portalsDoorSendHelp"
				}

			}
, 			{
				"box" : 				{
					"fontsize" : 9.0,
					"id" : "obj-365",
					"linecount" : 3,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 416.0, 209.0, 116.0, 37.0 ],
					"style" : "",
					"text" : "note: Clock Chair FSR will show unresponsive while video plays!"
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.21.41" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.21.41",
					"id" : "obj-336",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 876.0, 53.25, 127.0, 15.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 876.0, 33.75, 144.0, 15.0 ],
					"varname" : "pi10422141",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.21.45" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.21.45",
					"id" : "obj-335",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 467.0, 654.0, 140.0, 14.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 645.0, 524.5, 117.0, 15.0 ],
					"varname" : "pi10422145",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-88",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patcher" : 					{
						"fileversion" : 1,
						"appversion" : 						{
							"major" : 7,
							"minor" : 0,
							"revision" : 6,
							"architecture" : "x86",
							"modernui" : 1
						}
,
						"rect" : [ 192.0, 102.0, 640.0, 816.0 ],
						"bglocked" : 0,
						"openinpresentation" : 0,
						"default_fontsize" : 12.0,
						"default_fontface" : 0,
						"default_fontname" : "Arial",
						"gridonopen" : 1,
						"gridsize" : [ 15.0, 15.0 ],
						"gridsnaponopen" : 1,
						"objectsnaponopen" : 1,
						"statusbarvisible" : 2,
						"toolbarvisible" : 1,
						"lefttoolbarpinned" : 0,
						"toptoolbarpinned" : 0,
						"righttoolbarpinned" : 0,
						"bottomtoolbarpinned" : 0,
						"toolbars_unpinned_last_save" : 0,
						"tallnewobj" : 0,
						"boxanimatetime" : 200,
						"enablehscroll" : 1,
						"enablevscroll" : 1,
						"devicewidth" : 0.0,
						"description" : "",
						"digest" : "",
						"tags" : "",
						"style" : "",
						"subpatcher_template" : "",
						"boxes" : [ 							{
								"box" : 								{
									"id" : "obj-21",
									"linecount" : 3,
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 147.0, 229.5, 50.0, 49.0 ],
									"style" : "",
									"text" : "symbol <password>"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-44",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 147.0, 338.0, 100.0, 22.0 ],
									"style" : "",
									"text" : "v entryVidCmd"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-45",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 2,
									"outlettype" : [ "bang", "" ],
									"patching_rect" : [ 147.0, 312.0, 100.0, 22.0 ],
									"style" : "",
									"text" : "sel \"000\""
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-50",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 2,
									"outlettype" : [ "", "bang" ],
									"patching_rect" : [ 147.0, 286.0, 100.0, 22.0 ],
									"style" : "",
									"text" : "dialog password:"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-59",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 228.0, 236.0, 100.0, 22.0 ],
									"style" : "",
									"text" : "v entryVidCmd"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-60",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "bang", "" ],
									"patching_rect" : [ 147.0, 198.0, 100.0, 22.0 ],
									"style" : "",
									"text" : "t b s"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-40",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "", "bang" ],
									"patching_rect" : [ 147.0, 374.617065, 35.0, 22.0 ],
									"style" : "",
									"text" : "shell"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-38",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"patching_rect" : [ 342.875, 68.0, 60.0, 22.0 ],
									"style" : "",
									"text" : "loadbang"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-42",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 147.0, 427.0, 103.0, 22.0 ],
									"style" : "",
									"text" : "print entryVid"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-34",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 147.0, 401.0, 73.0, 22.0 ],
									"style" : "",
									"text" : "fromsymbol"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-77",
									"linecount" : 4,
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 147.0, 116.5, 289.0, 62.0 ],
									"style" : "",
									"text" : "sprintf \\\"/usr/bin/python /Users/Aesir/Documents/watchdog/Show_Automation/show_start_stop.py --no_delay --reboot_entry_videos\\\""
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-82",
									"maxclass" : "button",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"patching_rect" : [ 193.0, 33.0, 24.0, 24.0 ],
									"style" : ""
								}

							}
, 							{
								"box" : 								{
									"comment" : "",
									"id" : "obj-4",
									"maxclass" : "inlet",
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 120.0, 30.0, 30.0, 30.0 ],
									"style" : ""
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"destination" : [ "obj-50", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-21", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-42", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-34", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-77", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"midpoints" : [ 129.5, 87.75, 156.5, 87.75 ],
									"source" : [ "obj-4", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-34", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-40", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-40", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-44", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-44", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-45", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-45", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-50", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-21", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-60", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-59", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-60", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-60", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-77", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-77", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"midpoints" : [ 202.5, 86.25, 156.5, 86.25 ],
									"source" : [ "obj-82", 0 ]
								}

							}
 ],
						"styles" : [ 							{
								"name" : "AudioStatus_Menu",
								"default" : 								{
									"bgfillcolor" : 									{
										"type" : "color",
										"color" : [ 0.294118, 0.313726, 0.337255, 1 ],
										"color1" : [ 0.454902, 0.462745, 0.482353, 0.0 ],
										"color2" : [ 0.290196, 0.309804, 0.301961, 1.0 ],
										"angle" : 270.0,
										"proportion" : 0.39,
										"autogradient" : 0
									}

								}
,
								"parentstyle" : "",
								"multi" : 0
							}
 ]
					}
,
					"patching_rect" : [ 1499.0, 651.0, 100.0, 22.0 ],
					"saved_object_attributes" : 					{
						"description" : "",
						"digest" : "",
						"globalpatchername" : "",
						"style" : "",
						"tags" : ""
					}
,
					"style" : "",
					"text" : "p rebootBenji"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-89",
					"maxclass" : "textbutton",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "", "", "int" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1303.0, 654.0, 176.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1229.0, 429.5, 172.0, 20.0 ],
					"style" : "",
					"text" : "REBOOT entry video Pis",
					"varname" : "rebootdevs[4]"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-373",
					"linecount" : 3,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 1269.0, 313.0, 150.0, 47.0 ],
					"presentation" : 1,
					"presentation_linecount" : 2,
					"presentation_rect" : [ 1233.0, 192.0, 230.0, 33.0 ],
					"style" : "",
					"text" : "^^^ press for concert mode buttons & power automation!"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-314",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 1297.0, 446.0, 120.0, 22.0 ],
					"style" : "",
					"text" : "advancedPower"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-312",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 1297.0, 390.0, 50.0, 22.0 ],
					"style" : "",
					"text" : "open"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-313",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 1297.0, 415.0, 100.0, 22.0 ],
					"style" : "",
					"text" : "pcontrol"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-297",
					"maxclass" : "textbutton",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "", "", "int" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1297.0, 282.5, 196.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1231.0, 167.5, 221.0, 20.0 ],
					"style" : "",
					"text" : "Open Advanced Power Screen",
					"varname" : "poeoff[5]"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-367",
					"linecount" : 4,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 1308.0, 685.5, 150.0, 60.0 ],
					"presentation" : 1,
					"presentation_linecount" : 4,
					"presentation_rect" : [ 1240.0, 451.5, 150.0, 60.0 ],
					"style" : "",
					"text" : "start/stop entry hall intro video (Benji / Agent 35).\n\nOr simul-reboot the Pis..."
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.27.40" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.27.40",
					"id" : "obj-293",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 566.75, 154.0, 112.5, 15.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 502.25, 158.5, 162.5, 15.0 ],
					"varname" : "pi10422740",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.27.42" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.27.42",
					"id" : "obj-273",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 1087.0, 267.0, 100.0, 15.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1118.0, 274.875, 109.0, 15.0 ],
					"varname" : "pi10422742",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.27.41" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.27.41",
					"id" : "obj-170",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 1093.0, 129.0, 100.0, 15.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1118.0, 129.0, 112.0, 15.0 ],
					"varname" : "pi10422741",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.24.21" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.24.21",
					"id" : "obj-193",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 416.0, 281.5, 133.0, 12.5 ],
					"presentation" : 1,
					"presentation_rect" : [ 377.75, 281.5, 136.0, 14.5 ],
					"varname" : "pi10422421",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-191",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patcher" : 					{
						"fileversion" : 1,
						"appversion" : 						{
							"major" : 7,
							"minor" : 0,
							"revision" : 6,
							"architecture" : "x86",
							"modernui" : 1
						}
,
						"rect" : [ 181.0, 161.0, 640.0, 480.0 ],
						"bglocked" : 0,
						"openinpresentation" : 0,
						"default_fontsize" : 12.0,
						"default_fontface" : 0,
						"default_fontname" : "Arial",
						"gridonopen" : 1,
						"gridsize" : [ 15.0, 15.0 ],
						"gridsnaponopen" : 1,
						"objectsnaponopen" : 1,
						"statusbarvisible" : 2,
						"toolbarvisible" : 1,
						"lefttoolbarpinned" : 0,
						"toptoolbarpinned" : 0,
						"righttoolbarpinned" : 0,
						"bottomtoolbarpinned" : 0,
						"toolbars_unpinned_last_save" : 0,
						"tallnewobj" : 0,
						"boxanimatetime" : 200,
						"enablehscroll" : 1,
						"enablevscroll" : 1,
						"devicewidth" : 0.0,
						"description" : "",
						"digest" : "",
						"tags" : "",
						"style" : "",
						"subpatcher_template" : "",
						"boxes" : [ 							{
								"box" : 								{
									"comment" : "",
									"id" : "obj-2",
									"maxclass" : "inlet",
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 182.0, 19.0, 30.0, 30.0 ],
									"style" : ""
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-5",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 281.0, 109.0, 166.0, 22.0 ],
									"style" : "",
									"text" : "udpsend 10.42.27.42 9995"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-3",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 228.0, 55.0, 81.0, 22.0 ],
									"style" : "",
									"text" : "/playnormal"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-1",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 80.0, 109.0, 166.0, 22.0 ],
									"style" : "",
									"text" : "udpsend 10.42.27.41 9995"
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"destination" : [ "obj-3", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-2", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-1", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-3", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-5", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-3", 0 ]
								}

							}
 ]
					}
,
					"patching_rect" : [ 1499.0, 624.0, 100.0, 22.0 ],
					"saved_object_attributes" : 					{
						"description" : "",
						"digest" : "",
						"globalpatchername" : "",
						"style" : "",
						"tags" : ""
					}
,
					"style" : "",
					"text" : "p startBenji"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-171",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patcher" : 					{
						"fileversion" : 1,
						"appversion" : 						{
							"major" : 7,
							"minor" : 0,
							"revision" : 6,
							"architecture" : "x86",
							"modernui" : 1
						}
,
						"rect" : [ 59.0, 104.0, 640.0, 480.0 ],
						"bglocked" : 0,
						"openinpresentation" : 0,
						"default_fontsize" : 12.0,
						"default_fontface" : 0,
						"default_fontname" : "Arial",
						"gridonopen" : 1,
						"gridsize" : [ 15.0, 15.0 ],
						"gridsnaponopen" : 1,
						"objectsnaponopen" : 1,
						"statusbarvisible" : 2,
						"toolbarvisible" : 1,
						"lefttoolbarpinned" : 0,
						"toptoolbarpinned" : 0,
						"righttoolbarpinned" : 0,
						"bottomtoolbarpinned" : 0,
						"toolbars_unpinned_last_save" : 0,
						"tallnewobj" : 0,
						"boxanimatetime" : 200,
						"enablehscroll" : 1,
						"enablevscroll" : 1,
						"devicewidth" : 0.0,
						"description" : "",
						"digest" : "",
						"tags" : "",
						"style" : "",
						"subpatcher_template" : "",
						"boxes" : [ 							{
								"box" : 								{
									"comment" : "",
									"id" : "obj-2",
									"maxclass" : "inlet",
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 182.0, 19.0, 30.0, 30.0 ],
									"style" : ""
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-5",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 281.0, 109.0, 166.0, 22.0 ],
									"style" : "",
									"text" : "udpsend 10.42.27.42 9995"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-3",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 227.0, 55.0, 50.0, 22.0 ],
									"style" : "",
									"text" : "/stopall"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-1",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 80.0, 109.0, 166.0, 22.0 ],
									"style" : "",
									"text" : "udpsend 10.42.27.41 9995"
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"destination" : [ "obj-3", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-2", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-1", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-3", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-5", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-3", 0 ]
								}

							}
 ]
					}
,
					"patching_rect" : [ 1499.0, 599.5, 100.0, 22.0 ],
					"saved_object_attributes" : 					{
						"description" : "",
						"digest" : "",
						"globalpatchername" : "",
						"style" : "",
						"tags" : ""
					}
,
					"style" : "",
					"text" : "p stopBenji"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-152",
					"maxclass" : "textbutton",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "", "", "int" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1303.0, 627.0, 176.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1229.0, 398.5, 172.0, 20.0 ],
					"style" : "",
					"text" : "START entry videos",
					"varname" : "rebootdevs[8]"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-146",
					"maxclass" : "textbutton",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "", "", "int" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1303.0, 599.5, 176.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1229.0, 376.5, 172.0, 20.0 ],
					"style" : "",
					"text" : "STOP entry videos",
					"varname" : "rebootdevs[7]"
				}

			}
, 			{
				"box" : 				{
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"id" : "obj-192",
					"ignoreclick" : 1,
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "relayPanelGUI.maxpat",
					"numinlets" : 0,
					"numoutlets" : 0,
					"offset" : [ 0.0, 0.0 ],
					"patching_rect" : [ 482.0, 1062.5, 319.0, 317.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 26.0, 922.5, 319.0, 317.0 ],
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-59",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"patching_rect" : [ 1557.0, -40.0, 100.0, 22.0 ],
					"style" : "",
					"text" : "loadbang"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-429",
					"linecount" : 13,
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 817.5, 1003.5, 56.0, 183.0 ],
					"style" : "",
					"text" : "[;\rmax launch_browser http://localhost/nagios/cgi-bin/status.cgi?hostgroup=all&style=overview"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-427",
					"maxclass" : "textbutton",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "", "", "int" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 817.5, 968.0, 153.0, 23.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1403.0, 38.0, 172.0, 20.0 ],
					"style" : "",
					"text" : "Open Web Monitoring Page",
					"varname" : "rebootdevs[6]"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-426",
					"maxclass" : "toggle",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "int" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1557.0, -10.0, 24.0, 24.0 ],
					"style" : ""
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-424",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"patching_rect" : [ 1548.0, 21.0, 100.0, 22.0 ],
					"style" : "",
					"text" : "metro 60000"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-417",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 1478.0, 102.0, 150.0, 33.0 ],
					"presentation" : 1,
					"presentation_linecount" : 2,
					"presentation_rect" : [ 1488.0, -17.0, 150.0, 33.0 ],
					"style" : "",
					"text" : "server\nstatus:"
				}

			}
, 			{
				"box" : 				{
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"id" : "obj-414",
					"ignoreclick" : 1,
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "serverStatus.maxpat",
					"numinlets" : 1,
					"numoutlets" : 0,
					"offset" : [ 0.0, 0.0 ],
					"patching_rect" : [ 1474.0, -18.0, 36.0, 42.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1527.0, -21.5, 36.0, 42.0 ],
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-308",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 1432.5, 509.0, 150.0, 33.0 ],
					"presentation" : 1,
					"presentation_linecount" : 2,
					"presentation_rect" : [ 1233.0, 260.0, 150.0, 33.0 ],
					"style" : "",
					"text" : "press to cancel current on/off command..."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-87",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patcher" : 					{
						"fileversion" : 1,
						"appversion" : 						{
							"major" : 7,
							"minor" : 0,
							"revision" : 6,
							"architecture" : "x86",
							"modernui" : 1
						}
,
						"rect" : [ 210.0, 95.0, 373.0, 341.0 ],
						"bglocked" : 0,
						"openinpresentation" : 0,
						"default_fontsize" : 12.0,
						"default_fontface" : 0,
						"default_fontname" : "Arial",
						"gridonopen" : 1,
						"gridsize" : [ 15.0, 15.0 ],
						"gridsnaponopen" : 1,
						"objectsnaponopen" : 1,
						"statusbarvisible" : 2,
						"toolbarvisible" : 1,
						"lefttoolbarpinned" : 0,
						"toptoolbarpinned" : 0,
						"righttoolbarpinned" : 0,
						"bottomtoolbarpinned" : 0,
						"toolbars_unpinned_last_save" : 0,
						"tallnewobj" : 0,
						"boxanimatetime" : 200,
						"enablehscroll" : 1,
						"enablevscroll" : 1,
						"devicewidth" : 0.0,
						"description" : "",
						"digest" : "",
						"tags" : "",
						"style" : "",
						"subpatcher_template" : "",
						"boxes" : [ 							{
								"box" : 								{
									"id" : "obj-13",
									"linecount" : 3,
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 163.0, 28.0, 155.0, 47.0 ],
									"style" : "",
									"text" : "kills anything with show_start_stop.py on the command line!"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-11",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 89.0, 80.5, 236.0, 22.0 ],
									"style" : "",
									"text" : "/usr/bin/pkill -f show_start_stop.py"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-8",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 110.0, 116.0, 100.0, 22.0 ],
									"style" : "",
									"text" : "print killcmd"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-1",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 105.0, 218.0, 74.0, 22.0 ],
									"style" : "",
									"text" : "prepend set"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-5",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "ready" ],
									"patching_rect" : [ 105.0, 187.0, 47.0, 22.0 ],
									"style" : "",
									"text" : "t ready"
								}

							}
, 							{
								"box" : 								{
									"comment" : "",
									"id" : "obj-4",
									"maxclass" : "outlet",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 105.0, 256.0, 30.0, 30.0 ],
									"style" : ""
								}

							}
, 							{
								"box" : 								{
									"comment" : "",
									"id" : "obj-3",
									"maxclass" : "inlet",
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 89.0, 33.0, 30.0, 30.0 ],
									"style" : ""
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-40",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "", "bang" ],
									"patching_rect" : [ 89.0, 150.117065, 35.0, 22.0 ],
									"style" : "",
									"text" : "shell"
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"destination" : [ "obj-4", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-1", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-40", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-11", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-8", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-11", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-11", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-3", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-5", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"midpoints" : [ 114.5, 178.058533, 114.5, 178.058533 ],
									"source" : [ "obj-40", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-1", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-5", 0 ]
								}

							}
 ],
						"styles" : [ 							{
								"name" : "AudioStatus_Menu",
								"default" : 								{
									"bgfillcolor" : 									{
										"type" : "color",
										"color" : [ 0.294118, 0.313726, 0.337255, 1 ],
										"color1" : [ 0.454902, 0.462745, 0.482353, 0.0 ],
										"color2" : [ 0.290196, 0.309804, 0.301961, 1.0 ],
										"angle" : 270.0,
										"proportion" : 0.39,
										"autogradient" : 0
									}

								}
,
								"parentstyle" : "",
								"multi" : 0
							}
 ]
					}
,
					"patching_rect" : [ 1449.5, 483.5, 96.0, 22.0 ],
					"saved_object_attributes" : 					{
						"description" : "",
						"digest" : "",
						"globalpatchername" : "",
						"style" : "",
						"tags" : ""
					}
,
					"style" : "",
					"text" : "p cancel_onOff"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-86",
					"maxclass" : "textbutton",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "", "", "int" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1268.5, 483.5, 176.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1233.0, 237.0, 172.0, 20.0 ],
					"style" : "",
					"text" : "CANCEL on/off",
					"varname" : "rebootdevs[3]"
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.25.80" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.25.80",
					"id" : "obj-211",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 956.0, 130.5, 117.0, 17.5 ],
					"presentation" : 1,
					"presentation_rect" : [ 959.5, 129.0, 129.5, 16.25 ],
					"varname" : "pi10422580",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.25.44" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.25.44",
					"id" : "obj-207",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 683.5, 90.25, 129.0, 15.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 683.5, 113.0, 361.5, 14.0 ],
					"varname" : "pi10422544",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.24.45" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 1,
					"enablevscroll" : 0,
					"hint" : "10.42.24.45",
					"id" : "obj-206",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 566.75, 214.0, 133.5, 15.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 502.25, 219.5, 96.5, 15.0 ],
					"varname" : "pi10422445",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.20.93" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.20.93",
					"id" : "obj-203",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 305.0, 796.0, 77.0, 10.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 305.0, 796.0, 104.0, 10.0 ],
					"varname" : "pi10422093",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.20.92" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.20.92",
					"id" : "obj-168",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 66.5, 837.0, 118.5, 16.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 66.5, 831.0, 125.0, 15.0 ],
					"varname" : "pi10422092",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.20.91" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.20.91",
					"id" : "obj-136",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 66.5, 815.0, 118.5, 16.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 66.5, 816.0, 125.0, 15.0 ],
					"varname" : "pi10422091",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.20.90" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.20.90",
					"id" : "obj-127",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 66.5, 796.0, 118.5, 16.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 66.5, 801.0, 115.0, 15.0 ],
					"varname" : "pi10422090",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.21.40" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.21.40",
					"id" : "obj-55",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 486.5, 690.0, 241.0, 12.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 747.5, 597.0, 272.5, 12.0 ],
					"varname" : "pi10422140",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-299",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 1250.0, 941.0, 208.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1299.0, 884.0, 208.0, 20.0 ],
					"style" : "",
					"text" : "Black = Unknown/No Database Entry"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-298",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 1250.0, 925.0, 208.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1299.0, 868.0, 208.0, 20.0 ],
					"style" : "",
					"text" : "Red = No Response",
					"textcolor" : [ 0.784314, 0.145098, 0.023529, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-175",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 1250.0, 906.0, 208.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1299.0, 849.0, 208.0, 20.0 ],
					"style" : "",
					"text" : "Yellow = Check Software/Device",
					"textcolor" : [ 0.639216, 0.458824, 0.070588, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-174",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 1250.0, 888.0, 208.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1299.0, 831.0, 208.0, 20.0 ],
					"style" : "",
					"text" : "Green = Ok",
					"textcolor" : [ 0.0, 0.533333, 0.168627, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"fontface" : 1,
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-169",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 1250.0, 866.0, 208.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1299.0, 809.0, 208.0, 20.0 ],
					"style" : "",
					"text" : "Status color codes:"
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.21.43" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.21.43",
					"id" : "obj-166",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 465.5, 554.0, 142.0, 16.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 467.0, 541.5, 120.0, 16.0 ],
					"varname" : "pi10422143",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.21.42" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.21.42",
					"id" : "obj-164",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 465.5, 536.0, 142.0, 16.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 467.0, 524.5, 118.5, 16.0 ],
					"varname" : "pi10422142",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-162",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 1250.0, 836.0, 155.0, 33.0 ],
					"presentation" : 1,
					"presentation_linecount" : 2,
					"presentation_rect" : [ 1299.0, 779.0, 155.0, 33.0 ],
					"style" : "",
					"text" : "Black = Other Pis & Arduinos"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-128",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 1250.0, 817.0, 150.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1299.0, 760.0, 150.0, 20.0 ],
					"style" : "",
					"text" : "Blue = Global Audio Pis",
					"textcolor" : [ 0.011765, 0.396078, 0.752941, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-126",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 1250.0, 796.0, 150.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1299.0, 739.0, 150.0, 20.0 ],
					"style" : "",
					"text" : "Orange = Servers",
					"textcolor" : [ 0.572549, 0.27451, 0.027451, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"fontface" : 1,
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-90",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 1250.0, 777.0, 150.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1299.0, 720.0, 150.0, 20.0 ],
					"style" : "",
					"text" : "Device color codes:\n"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-45",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patcher" : 					{
						"fileversion" : 1,
						"appversion" : 						{
							"major" : 7,
							"minor" : 0,
							"revision" : 6,
							"architecture" : "x86",
							"modernui" : 1
						}
,
						"rect" : [ 34.0, 140.0, 622.0, 536.0 ],
						"bglocked" : 0,
						"openinpresentation" : 0,
						"default_fontsize" : 12.0,
						"default_fontface" : 0,
						"default_fontname" : "Arial",
						"gridonopen" : 1,
						"gridsize" : [ 15.0, 15.0 ],
						"gridsnaponopen" : 1,
						"objectsnaponopen" : 1,
						"statusbarvisible" : 2,
						"toolbarvisible" : 1,
						"lefttoolbarpinned" : 0,
						"toptoolbarpinned" : 0,
						"righttoolbarpinned" : 0,
						"bottomtoolbarpinned" : 0,
						"toolbars_unpinned_last_save" : 0,
						"tallnewobj" : 0,
						"boxanimatetime" : 200,
						"enablehscroll" : 1,
						"enablevscroll" : 1,
						"devicewidth" : 0.0,
						"description" : "",
						"digest" : "",
						"tags" : "",
						"style" : "",
						"subpatcher_template" : "",
						"boxes" : [ 							{
								"box" : 								{
									"id" : "obj-58",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 186.203125, 100.0, 94.0, 22.0 ],
									"style" : "",
									"text" : "s searchResults"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-5",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 52.0, 100.0, 100.0, 22.0 ],
									"style" : "",
									"text" : "searchBox"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-312",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 52.0, 45.0, 50.0, 22.0 ],
									"style" : "",
									"text" : "open"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-313",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 52.0, 70.0, 100.0, 22.0 ],
									"style" : "",
									"text" : "pcontrol"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-4",
									"linecount" : 2,
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 154.75, 468.0, 397.0, 33.0 ],
									"style" : "",
									"text" : "sends a \"front\" message to the node.maxpat object with this IP address,\nto bring it up"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-31",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patcher" : 									{
										"fileversion" : 1,
										"appversion" : 										{
											"major" : 7,
											"minor" : 0,
											"revision" : 6,
											"architecture" : "x86",
											"modernui" : 1
										}
,
										"rect" : [ 34.0, 125.0, 742.0, 480.0 ],
										"bglocked" : 0,
										"openinpresentation" : 0,
										"default_fontsize" : 12.0,
										"default_fontface" : 0,
										"default_fontname" : "Arial",
										"gridonopen" : 1,
										"gridsize" : [ 15.0, 15.0 ],
										"gridsnaponopen" : 1,
										"objectsnaponopen" : 1,
										"statusbarvisible" : 2,
										"toolbarvisible" : 1,
										"lefttoolbarpinned" : 0,
										"toptoolbarpinned" : 0,
										"righttoolbarpinned" : 0,
										"bottomtoolbarpinned" : 0,
										"toolbars_unpinned_last_save" : 0,
										"tallnewobj" : 0,
										"boxanimatetime" : 200,
										"enablehscroll" : 1,
										"enablevscroll" : 1,
										"devicewidth" : 0.0,
										"description" : "",
										"digest" : "",
										"tags" : "",
										"style" : "",
										"subpatcher_template" : "",
										"boxes" : [ 											{
												"box" : 												{
													"comment" : "",
													"id" : "obj-5",
													"maxclass" : "outlet",
													"numinlets" : 1,
													"numoutlets" : 0,
													"patching_rect" : [ 116.0, 282.0, 30.0, 30.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"comment" : "",
													"id" : "obj-2",
													"maxclass" : "inlet",
													"numinlets" : 0,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 116.0, 21.0, 30.0, 30.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-91",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 2,
													"outlettype" : [ "", "" ],
													"patching_rect" : [ 116.0, 207.0, 88.0, 22.0 ],
													"style" : "",
													"text" : "t s s"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-19",
													"maxclass" : "newobj",
													"numinlets" : 2,
													"numoutlets" : 2,
													"outlettype" : [ "", "" ],
													"patching_rect" : [ 116.0, 244.0, 163.0, 22.0 ],
													"style" : "",
													"text" : "route ID_NAME"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-3",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 116.0, 143.0, 74.0, 22.0 ],
													"saved_object_attributes" : 													{
														"filename" : "watchgod",
														"parameter_enable" : 0
													}
,
													"style" : "",
													"text" : "js watchgod"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-1",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "bang" ],
													"patching_rect" : [ 265.75, 119.0, 60.0, 22.0 ],
													"style" : "",
													"text" : "loadbang"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-45",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 116.0, 112.0, 100.0, 22.0 ],
													"style" : "",
													"text" : "prepend exec"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-25",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 116.0, 174.0, 73.0, 22.0 ],
													"style" : "",
													"text" : "fromsymbol"
												}

											}
, 											{
												"box" : 												{
													"fontname" : "Verdana",
													"fontsize" : 9.873845,
													"id" : "obj-119",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 265.75, 143.0, 482.0, 20.0 ],
													"style" : "",
													"text" : "opendb \"Macintosh HD:/Users/Aesir/Documents/watchdog/tcp_watchdog_server/demosdb.db\""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-113",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 116.0, 65.0, 559.0, 22.0 ],
													"style" : "",
													"text" : "sprintf \\\"SELECT ID_NAME FROM devices where DEVICE_NAME like '%s'\\\""
												}

											}
 ],
										"lines" : [ 											{
												"patchline" : 												{
													"destination" : [ "obj-119", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-1", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-45", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-113", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-3", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-119", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-5", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-19", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-113", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-2", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-91", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-25", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-25", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-3", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-3", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-45", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-19", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-91", 0 ]
												}

											}
 ]
									}
,
									"patching_rect" : [ 360.25, 265.0, 121.75, 22.0 ],
									"saved_object_attributes" : 									{
										"description" : "",
										"digest" : "",
										"globalpatchername" : "",
										"style" : "",
										"tags" : ""
									}
,
									"style" : "",
									"text" : "p findDeviceName"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-30",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 155.5, 334.0, 100.0, 22.0 ],
									"style" : "",
									"text" : "print searched"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-28",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 392.0, 238.0, 169.0, 20.0 ],
									"style" : "",
									"text" : "handles device name search"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-25",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 179.25, 238.0, 167.0, 20.0 ],
									"style" : "",
									"text" : "handles IP address search"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-54",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 5,
									"outlettype" : [ "", "", "", "", "" ],
									"patching_rect" : [ 155.5, 265.0, 200.875, 22.0 ],
									"style" : "",
									"text" : "unjoin 4"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-38",
									"maxclass" : "newobj",
									"numinlets" : 4,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 155.5, 302.0, 155.40625, 22.0 ],
									"style" : "",
									"text" : "sprintf %i.%i.%i.%i"
								}

							}
, 							{
								"box" : 								{
									"fontface" : 0,
									"fontname" : "Arial",
									"fontsize" : 13.0,
									"id" : "obj-36",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 5,
									"outlettype" : [ "", "", "", "", "" ],
									"patching_rect" : [ 52.0, 203.0, 430.0, 23.0 ],
									"style" : "",
									"text" : "regexp (\\\\d+)\\\\.(\\\\d+)\\\\.(\\\\d+)\\\\.(\\\\d+)"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-18",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 235.75, 404.0, 100.0, 22.0 ],
									"style" : "",
									"text" : "sprintf send %s"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-17",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 154.75, 440.0, 100.0, 22.0 ],
									"style" : "",
									"text" : "forward"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-13",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "front", "" ],
									"patching_rect" : [ 154.75, 374.0, 100.0, 22.0 ],
									"style" : "",
									"text" : "t front s"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-12",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 2,
									"outlettype" : [ "", "" ],
									"patching_rect" : [ 52.0, 170.0, 100.0, 22.0 ],
									"style" : "",
									"text" : "route symbol"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-1",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 2,
									"outlettype" : [ "", "bang" ],
									"patching_rect" : [ 52.0, 136.0, 237.0, 22.0 ],
									"style" : "",
									"text" : "dialog \"Enter IP Address or Device Name\""
								}

							}
, 							{
								"box" : 								{
									"comment" : "",
									"id" : "obj-11",
									"maxclass" : "inlet",
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 52.0, 11.0, 30.0, 30.0 ],
									"style" : ""
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"destination" : [ "obj-12", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-1", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-312", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-11", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-58", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-11", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-36", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-12", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-17", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-13", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-18", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-13", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-17", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"midpoints" : [ 245.25, 432.0, 164.25, 432.0 ],
									"source" : [ "obj-18", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-13", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"midpoints" : [ 369.75, 364.0, 164.25, 364.0 ],
									"source" : [ "obj-31", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-30", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"midpoints" : [ 369.75, 328.0, 165.0, 328.0 ],
									"source" : [ "obj-31", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-313", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-312", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-5", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-313", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-31", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-36", 3 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-54", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-36", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-13", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-38", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-30", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-38", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-38", 3 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-54", 3 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-38", 2 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-54", 2 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-38", 1 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-54", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-38", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-54", 0 ]
								}

							}
 ],
						"styles" : [ 							{
								"name" : "AudioStatus_Menu",
								"default" : 								{
									"bgfillcolor" : 									{
										"type" : "color",
										"color" : [ 0.294118, 0.313726, 0.337255, 1 ],
										"color1" : [ 0.454902, 0.462745, 0.482353, 0.0 ],
										"color2" : [ 0.290196, 0.309804, 0.301961, 1.0 ],
										"angle" : 270.0,
										"proportion" : 0.39,
										"autogradient" : 0
									}

								}
,
								"parentstyle" : "",
								"multi" : 0
							}
 ]
					}
,
					"patching_rect" : [ 1478.0, 79.0, 59.0, 22.0 ],
					"saved_object_attributes" : 					{
						"description" : "",
						"digest" : "",
						"globalpatchername" : "",
						"style" : "",
						"tags" : ""
					}
,
					"style" : "",
					"text" : "p Search",
					"varname" : "patcher"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-51",
					"maxclass" : "textbutton",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "", "", "int" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1297.0, 79.0, 176.0, 22.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1231.0, 79.0, 254.0, 32.0 ],
					"style" : "",
					"text" : "Search By IP/Device Name/Description",
					"varname" : "rebootdevs[2]"
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.0.113" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.0.113",
					"id" : "obj-363",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 186.5, 5.0, 82.0, 15.0 ],
					"varname" : "pi10420113",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.24.40" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.24.40",
					"id" : "obj-361",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 315.0, 69.0, 283.0, 19.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 315.0, 67.0, 87.0, 11.0 ],
					"varname" : "pi10422440",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.24.44" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.24.44",
					"id" : "obj-359",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 566.75, 196.0, 133.5, 15.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 450.0, 252.0, 209.0, 15.0 ],
					"varname" : "pi10422444",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.24.85" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.24.85",
					"id" : "obj-356",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 566.75, 176.0, 133.5, 15.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 502.25, 180.5, 149.75, 15.0 ],
					"varname" : "pi10422485",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.24.20" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.24.20",
					"id" : "obj-354",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 518.0, 302.5, 231.0, 11.5 ],
					"presentation" : 1,
					"presentation_rect" : [ 518.0, 285.5, 127.0, 11.5 ],
					"varname" : "pi10422420",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.24.42" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.24.42",
					"id" : "obj-353",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 519.0, 373.5, 153.0, 12.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 518.0, 358.5, 153.0, 12.0 ],
					"varname" : "pi10422442",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.24.43" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.24.43",
					"id" : "obj-351",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 518.0, 323.0, 319.0, 12.5 ],
					"presentation" : 1,
					"presentation_rect" : [ 467.0, 341.0, 326.0, 15.0 ],
					"varname" : "pi10422443",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.24.81" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.24.81",
					"id" : "obj-348",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 519.0, 356.0, 153.0, 12.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 518.0, 321.0, 160.0, 14.0 ],
					"varname" : "pi10422481",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.24.82" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.24.82",
					"id" : "obj-346",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 519.0, 338.5, 245.0, 12.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 518.0, 302.0, 73.0, 13.0 ],
					"varname" : "pi10422482",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.24.84" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.24.83",
					"id" : "obj-344",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 518.0, 267.0, 133.0, 12.5 ],
					"varname" : "pi10422483",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.24.84" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.24.84",
					"id" : "obj-342",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 679.0, 452.5, 85.0, 13.5 ],
					"presentation" : 1,
					"presentation_rect" : [ 515.0, 269.0, 159.0, 15.0 ],
					"varname" : "pi10422484",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.22.85" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.22.85",
					"id" : "obj-339",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 239.0, 228.0, 139.0, 14.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 239.0, 228.0, 159.0, 14.0 ],
					"varname" : "pi10422285",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.22.86" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.22.86",
					"id" : "obj-341",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 239.0, 209.0, 139.0, 14.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 239.0, 209.0, 135.0, 14.0 ],
					"varname" : "pi10422286",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.22.52" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.22.52",
					"id" : "obj-329",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 239.0, 249.0, 293.0, 15.5 ],
					"presentation" : 1,
					"presentation_rect" : [ 239.0, 252.0, 159.0, 12.5 ],
					"varname" : "pi10422252",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.22.50" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.22.50",
					"id" : "obj-333",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 207.0, 145.0, 293.0, 15.5 ],
					"presentation" : 1,
					"presentation_rect" : [ 161.75, 135.0, 352.0, 17.0 ],
					"varname" : "pi10422250",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.22.55" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.22.55",
					"id" : "obj-327",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 360.0, 367.5, 90.25, 17.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 361.875, 352.0, 90.25, 14.0 ],
					"varname" : "pi10422255",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.22.56" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.22.56",
					"id" : "obj-325",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 361.875, 302.5, 90.25, 17.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 361.875, 309.0, 90.25, 17.0 ],
					"varname" : "pi10422256",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.22.57" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.22.57",
					"id" : "obj-323",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 360.0, 345.0, 90.25, 17.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 361.875, 337.0, 90.25, 17.0 ],
					"varname" : "pi10422257",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.22.58" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.22.58",
					"id" : "obj-321",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 360.0, 323.0, 90.25, 17.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 361.875, 323.0, 90.25, 17.0 ],
					"varname" : "pi10422258",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.22.53" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.22.53",
					"id" : "obj-319",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 233.75, 391.0, 239.5, 12.5 ],
					"presentation" : 1,
					"presentation_rect" : [ 277.0, 391.0, 156.5, 12.5 ],
					"varname" : "pi10422253",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.22.54" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.22.54",
					"id" : "obj-317",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 233.75, 369.5, 216.5, 15.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 277.0, 369.5, 213.0, 15.0 ],
					"varname" : "pi10422254",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.23.80" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.23.80",
					"id" : "obj-310",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 68.0, 396.0, 71.0, 15.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 68.0, 396.0, 174.0, 15.0 ],
					"varname" : "pi10422380",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.23.43" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.23.43",
					"id" : "obj-307",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 67.0, 338.5, 238.0, 16.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 67.0, 274.25, 307.0, 16.0 ],
					"varname" : "pi10422343",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.23.44" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.23.44",
					"id" : "obj-305",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 67.0, 317.0, 238.0, 16.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 68.0, 420.0, 170.0, 16.0 ],
					"varname" : "pi10422344",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.23.45" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.23.45",
					"id" : "obj-303",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 67.0, 296.5, 238.0, 16.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 67.0, 295.0, 256.5, 16.0 ],
					"varname" : "pi10422345",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.21.87" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.21.87",
					"id" : "obj-300",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 530.0, 466.0, 121.0, 15.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 519.0, 457.0, 185.25, 14.0 ],
					"varname" : "pi10422187",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.23.40" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.23.40",
					"id" : "obj-295",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 121.0, 466.0, 248.0, 12.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 117.25, 458.0, 182.75, 12.0 ],
					"varname" : "pi10422340",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.23.81" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.23.81",
					"id" : "obj-290",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 196.5, 446.0, 82.0, 15.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 196.5, 442.0, 170.0, 15.0 ],
					"varname" : "pi10422381",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.22.84" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.22.84",
					"id" : "obj-288",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 395.0, 412.0, 146.0, 15.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 390.0, 415.0, 146.0, 15.0 ],
					"varname" : "pi10422284",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.22.83" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.22.83",
					"id" : "obj-286",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 395.0, 433.0, 146.0, 15.0 ],
					"varname" : "pi10422283",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.22.48" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.22.48",
					"id" : "obj-283",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 98.0, 590.5, 219.0, 12.5 ],
					"presentation" : 1,
					"presentation_rect" : [ 184.75, 590.5, 113.0, 12.5 ],
					"varname" : "pi10422248",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.20.45" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.20.45",
					"id" : "obj-281",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 146.5, 617.0, 187.0, 12.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 184.75, 621.0, 216.0, 12.0 ],
					"varname" : "pi10422045",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.20.21" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.20.21",
					"id" : "obj-278",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 70.5, 771.0, 193.5, 10.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 155.0, 754.0, 83.0, 10.0 ],
					"varname" : "pi10422021",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.20.80" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.20.80",
					"id" : "obj-276",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 224.0, 837.0, 147.0, 10.0 ],
					"varname" : "pi10422080",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.20.41" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.20.41",
					"id" : "obj-274",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 70.5, 754.0, 193.5, 10.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 123.5, 677.25, 193.5, 14.5 ],
					"varname" : "pi10422041",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.20.87" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.20.87",
					"id" : "obj-270",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 224.0, 802.5, 68.5, 10.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 224.0, 812.0, 68.5, 10.0 ],
					"varname" : "pi10422087",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.20.85" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.20.85",
					"id" : "obj-268",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 224.0, 817.0, 145.0, 10.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 224.0, 824.0, 121.0, 10.0 ],
					"varname" : "pi10422085",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.20.86" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.20.86",
					"id" : "obj-266",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 329.0, 731.0, 73.0, 12.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 329.0, 739.0, 115.25, 10.0 ],
					"varname" : "pi10422086",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.22.40" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.22.40",
					"id" : "obj-265",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 329.0, 754.0, 225.0, 14.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 277.0, 760.0, 175.125, 14.0 ],
					"varname" : "pi10422240",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.22.81" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.22.81",
					"id" : "obj-262",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 139.5, 567.0, 72.0, 12.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 184.75, 574.0, 132.25, 12.0 ],
					"varname" : "pi10422281",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.22.20" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.22.20",
					"id" : "obj-260",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 301.0, 515.0, 109.0, 12.5 ],
					"presentation" : 1,
					"presentation_rect" : [ 289.0, 509.0, 150.0, 12.5 ],
					"varname" : "pi10422220",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.22.45" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.22.45",
					"id" : "obj-259",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 299.0, 536.0, 104.0, 11.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 289.0, 527.0, 104.0, 11.0 ],
					"varname" : "pi10422245",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.22.80" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.22.80",
					"id" : "obj-256",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 299.0, 570.0, 109.0, 12.5 ],
					"presentation" : 1,
					"presentation_rect" : [ 382.25, 581.0, 62.0, 12.5 ],
					"varname" : "pi10422280",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.22.44" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.22.44",
					"id" : "obj-255",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 299.0, 554.0, 133.0, 10.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 390.0, 434.0, 192.5, 15.0 ],
					"varname" : "pi10422244",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.22.47" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.22.47",
					"id" : "obj-253",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 278.5, 638.0, 130.0, 18.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 222.0, 638.0, 82.0, 15.0 ],
					"varname" : "pi10422247",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.22.46" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.22.46",
					"id" : "obj-251",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 178.0, 713.0, 224.0, 18.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 155.0, 712.75, 224.0, 13.0 ],
					"varname" : "pi10422246",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.22.42" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.22.42",
					"id" : "obj-249",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 207.0, 164.5, 121.0, 14.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 203.5, 155.0, 127.0, 14.0 ],
					"varname" : "pi10422242",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.22.41" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.22.41",
					"id" : "obj-247",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 339.0, 606.0, 121.0, 14.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 264.25, 488.0, 137.75, 14.0 ],
					"varname" : "pi10422241",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.22.43" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.22.43",
					"id" : "obj-245",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 70.5, 731.0, 106.0, 15.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 139.5, 694.75, 82.0, 15.0 ],
					"varname" : "pi10422243",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.21.18" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.21.18",
					"id" : "obj-242",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 890.0, 317.0, 112.0, 14.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 890.0, 317.0, 123.0, 14.0 ],
					"varname" : "pi10422118",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.21.89" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.21.89",
					"id" : "obj-240",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 467.0, 591.0, 152.0, 13.5 ],
					"presentation" : 1,
					"presentation_rect" : [ 465.5, 581.0, 117.0, 12.0 ],
					"varname" : "pi10422189",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.21.83" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.21.83",
					"id" : "obj-238",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 467.0, 570.0, 152.0, 13.5 ],
					"varname" : "pi10422183",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.20.94" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.20.94",
					"id" : "obj-236",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 485.5, 713.0, 103.0, 11.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 460.0, 739.0, 103.0, 11.0 ],
					"varname" : "pi10422094",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.20.44" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.20.44",
					"id" : "obj-235",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 467.0, 783.0, 120.0, 14.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 467.0, 783.0, 120.0, 14.0 ],
					"varname" : "pi10422044",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.20.84" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.20.84",
					"id" : "obj-222",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 467.0, 799.0, 118.0, 12.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 467.0, 799.0, 92.0, 12.0 ],
					"varname" : "pi10422084",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.20.83" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.20.83",
					"id" : "obj-147",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 467.0, 815.0, 118.0, 12.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 654.0, 809.0, 92.0, 12.0 ],
					"varname" : "pi10422083",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.20.82" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.20.82",
					"id" : "obj-143",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 467.0, 837.0, 118.0, 12.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 654.0, 823.0, 92.0, 12.0 ],
					"varname" : "pi10422082",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.24.80" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.24.80",
					"id" : "obj-232",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 637.0, 281.5, 118.5, 16.5 ],
					"presentation" : 1,
					"presentation_rect" : [ 598.5, 300.0, 124.0, 15.0 ],
					"varname" : "pi10422480",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.0.111" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.0.111",
					"id" : "obj-230",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 1102.0, 6.0, 74.0, 11.0 ],
					"varname" : "pi10420111",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.25.41" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.25.41",
					"id" : "obj-228",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 683.5, 31.25, 193.5, 15.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 876.0, 53.25, 243.0, 15.0 ],
					"varname" : "pi10422541",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.25.91" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.25.91",
					"id" : "obj-226",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 683.5, 71.75, 118.0, 15.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 959.5, 146.0, 129.5, 15.0 ],
					"varname" : "pi10422591",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.25.42" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.25.42",
					"id" : "obj-224",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 683.5, 108.75, 208.5, 15.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 683.5, 89.5, 146.5, 15.0 ],
					"varname" : "pi10422542",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.25.21" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.25.21",
					"id" : "obj-220",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 683.5, 53.25, 118.0, 15.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 683.5, 65.0, 118.0, 15.0 ],
					"varname" : "pi10422521",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.25.85" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.25.85",
					"id" : "obj-216",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 789.0, 190.0, 113.0, 13.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 923.0, 200.5, 117.0, 13.0 ],
					"varname" : "pi10422585",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.25.82" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.25.82",
					"id" : "obj-214",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 744.0, 163.0, 126.0, 15.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 738.0, 167.5, 133.5, 15.0 ],
					"varname" : "pi10422582",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.25.84" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.25.84",
					"id" : "obj-212",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 783.5, 209.0, 118.5, 16.5 ],
					"presentation" : 1,
					"presentation_rect" : [ 783.5, 209.0, 124.0, 14.0 ],
					"varname" : "pi10422584",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.25.83" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.25.83",
					"id" : "obj-208",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 728.5, 235.0, 126.0, 15.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 737.5, 237.0, 126.0, 15.0 ],
					"varname" : "pi10422583",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.25.89" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.25.89",
					"id" : "obj-200",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 744.0, 137.0, 133.0, 16.5 ],
					"presentation" : 1,
					"presentation_rect" : [ 726.0, 146.0, 137.5, 15.0 ],
					"varname" : "pi10422589",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.0.112" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.0.112",
					"id" : "obj-198",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 706.0, 5.0, 95.0, 15.0 ],
					"varname" : "pi10420112",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.25.20" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.25.20",
					"id" : "obj-196",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 952.5, 231.0, 290.0, 15.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 890.0, 292.5, 155.0, 15.0 ],
					"varname" : "pi10422520",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.25.40" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.25.40",
					"id" : "obj-194",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 962.25, 214.0, 139.5, 10.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 941.625, 228.0, 112.5, 14.0 ],
					"varname" : "pi10422540",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.25.92" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.25.92",
					"id" : "obj-188",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 965.75, 190.0, 85.5, 15.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 959.5, 180.5, 91.0, 15.0 ],
					"varname" : "pi10422592",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.25.93" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.25.93",
					"id" : "obj-186",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 876.0, 71.75, 131.0, 15.5 ],
					"varname" : "pi10422593",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.25.94" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.25.94",
					"id" : "obj-184",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 956.0, 151.0, 152.0, 16.5 ],
					"varname" : "pi10422594",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.25.90" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.25.90",
					"id" : "obj-182",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 876.0, 88.75, 131.0, 15.5 ],
					"presentation" : 1,
					"presentation_rect" : [ 876.0, 71.5, 93.0, 14.75 ],
					"varname" : "pi10422590",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.25.43" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.25.43",
					"id" : "obj-180",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 956.0, 171.0, 109.0, 13.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 959.5, 164.0, 147.0, 14.0 ],
					"varname" : "pi10422543",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.25.81" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.25.81",
					"id" : "obj-178",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 890.0, 271.25, 69.0, 15.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 890.0, 274.25, 155.0, 15.625 ],
					"varname" : "pi10422581",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.17.40" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.17.40",
					"id" : "obj-176",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 952.5, 373.5, 183.0, 13.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 952.5, 373.5, 171.5, 15.0 ],
					"varname" : "pi10421740",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.21.88" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.21.88",
					"id" : "obj-173",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 683.5, 410.5, 119.0, 16.5 ],
					"varname" : "pi10422188",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.17.80" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.17.80",
					"id" : "obj-160",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 982.0, 405.5, 97.0, 15.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 984.125, 434.0, 166.0, 15.5 ],
					"varname" : "pi10421780",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.17.42" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.17.42",
					"id" : "obj-159",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 753.0, 369.5, 121.0, 15.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 766.0, 380.5, 130.0, 15.0 ],
					"varname" : "pi10421742",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.17.41" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.17.41",
					"id" : "obj-157",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 753.0, 347.0, 121.0, 15.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 766.0, 365.5, 150.0, 15.0 ],
					"varname" : "pi10421741",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.17.44" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.17.44",
					"id" : "obj-155",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 744.5, 391.0, 311.0, 15.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 755.5, 398.5, 246.0, 15.0 ],
					"varname" : "pi10421744",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.20.89" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.20.89",
					"id" : "obj-153",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 640.5, 805.5, 94.0, 10.5 ],
					"varname" : "pi10422089",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.20.20" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.20.20",
					"id" : "obj-151",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 640.5, 786.5, 94.0, 12.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 654.0, 778.0, 94.0, 12.0 ],
					"varname" : "pi10422020",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.20.40" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.20.40",
					"id" : "obj-150",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 789.0, 813.5, 223.0, 11.5 ],
					"presentation" : 1,
					"presentation_rect" : [ 760.0, 824.0, 227.0, 12.0 ],
					"varname" : "pi10422040",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.21.80" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.21.80",
					"id" : "obj-138",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 669.0, 567.0, 128.5, 14.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 645.0, 541.5, 132.5, 16.0 ],
					"varname" : "pi10422180",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.17.86" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.17.86",
					"id" : "obj-134",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 797.0, 518.0, 121.0, 14.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 797.0, 517.0, 119.0, 15.0 ],
					"varname" : "pi10421786",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.17.87" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.17.87",
					"id" : "obj-132",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 797.0, 498.0, 121.0, 14.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 797.0, 497.0, 119.0, 15.0 ],
					"varname" : "pi10421787",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.17.85" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.17.85",
					"id" : "obj-130",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 1045.0, 475.0, 106.0, 15.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1045.0, 475.0, 97.0, 15.0 ],
					"varname" : "pi10421785",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.18.40" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.18.40",
					"id" : "obj-125",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 927.0, 518.0, 282.0, 14.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 908.75, 534.0, 344.0, 14.0 ],
					"varname" : "pi10421840",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.40.152" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.40.152",
					"id" : "obj-123",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 1079.75, 498.0, 120.0, 15.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1061.75, 497.0, 118.0, 15.0 ],
					"varname" : "pi104240152",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.20.81" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.20.81",
					"id" : "obj-120",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 640.5, 838.0, 87.0, 15.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 654.0, 837.0, 104.0, 15.0 ],
					"varname" : "pi10422081",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.18.94" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.18.94",
					"id" : "obj-118",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 876.0, 646.0, 64.0, 15.0 ],
					"varname" : "pi10421894",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.18.88" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.18.88",
					"id" : "obj-116",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 1089.0, 836.0, 104.0, 15.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1032.0, 730.5, 164.0, 13.0 ],
					"varname" : "pi10421888",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.17.83" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.17.83",
					"id" : "obj-114",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 876.0, 554.0, 175.25, 15.0 ],
					"varname" : "pi10421783",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.18.85" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.18.85",
					"id" : "obj-112",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 1102.0, 661.0, 114.0, 10.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1045.0, 665.0, 165.0, 15.0 ],
					"varname" : "pi10421885",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.18.84" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.18.84",
					"id" : "obj-110",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 1011.0, 638.0, 155.0, 15.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1007.0, 638.0, 161.0, 15.0 ],
					"varname" : "pi10421884",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.18.86" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.18.86",
					"id" : "obj-100",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 1035.0, 715.0, 150.0, 15.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1012.5, 706.0, 150.0, 15.0 ],
					"varname" : "pi10421886",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.18.87" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.18.87",
					"id" : "obj-84",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 1087.0, 793.5, 138.0, 17.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 870.0, 843.0, 138.0, 15.0 ],
					"varname" : "pi10421887",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.18.82" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.18.82",
					"id" : "obj-108",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 807.0, 614.0, 174.0, 14.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 807.0, 614.0, 174.0, 14.0 ],
					"varname" : "pi10421882",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.18.81" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.18.81",
					"id" : "obj-106",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 679.0, 647.5, 106.5, 13.5 ],
					"presentation" : 1,
					"presentation_rect" : [ 674.5, 642.0, 107.0, 15.0 ],
					"varname" : "pi10421881",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.18.80" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.18.80",
					"id" : "obj-104",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 674.5, 661.0, 111.0, 15.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 674.5, 661.0, 174.0, 15.0 ],
					"varname" : "pi10421880",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.18.83" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.18.83",
					"id" : "obj-99",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 789.0, 706.0, 169.0, 15.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 789.0, 706.0, 169.0, 15.0 ],
					"varname" : "pi10421883",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.18.91" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.18.91",
					"id" : "obj-95",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 777.0, 828.0, 89.5, 16.5 ],
					"presentation" : 1,
					"presentation_rect" : [ 755.5, 840.5, 98.5, 11.5 ],
					"varname" : "pi10421891",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.18.21" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.18.21",
					"id" : "obj-93",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 825.0, 793.5, 211.0, 15.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 760.0, 778.0, 131.0, 15.0 ],
					"varname" : "pi10421821",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.18.44" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.18.44",
					"id" : "obj-72",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 807.0, 536.0, 211.0, 15.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 807.0, 579.5, 139.0, 15.0 ],
					"varname" : "pi10421844",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.18.43" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.18.43",
					"id" : "obj-68",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 753.0, 682.0, 236.0, 17.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 676.0, 677.25, 150.0, 14.5 ],
					"varname" : "pi10421843",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.18.42" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.18.42",
					"id" : "obj-67",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 825.0, 749.5, 191.0, 15.5 ],
					"presentation" : 1,
					"presentation_rect" : [ 825.0, 754.0, 144.0, 13.0 ],
					"varname" : "pi10421842",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.18.41" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.18.41",
					"id" : "obj-60",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 825.0, 726.5, 191.0, 16.5 ],
					"presentation" : 1,
					"presentation_rect" : [ 825.0, 730.5, 138.75, 15.0 ],
					"varname" : "pi10421841",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.18.45" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.18.45",
					"id" : "obj-56",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 1087.0, 769.5, 138.0, 15.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 825.0, 801.0, 156.0, 15.0 ],
					"varname" : "pi10421845",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.18.46" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.18.46",
					"id" : "obj-36",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 1011.0, 869.0, 216.0, 14.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 994.0, 754.0, 216.0, 14.0 ],
					"varname" : "pi10421846",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"args" : [ "10.42.18.47" ],
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"hint" : "10.42.18.47",
					"id" : "obj-34",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "node.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "int" ],
					"patching_rect" : [ 1011.0, 853.0, 216.0, 14.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 952.5, 778.0, 268.0, 14.0 ],
					"varname" : "pi10421847",
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"bgcolor" : [ 0.290196, 0.309804, 0.301961, 0.0 ],
					"degrees" : 360,
					"id" : "obj-82",
					"maxclass" : "dial",
					"needlecolor" : [ 0.541176, 0.815686, 0.913725, 1.0 ],
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "float" ],
					"outlinecolor" : [ 0.376471, 0.384314, 0.4, 0.0 ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1409.0, -10.0, 27.0, 27.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1373.0, -8.5, 26.0, 26.0 ],
					"size" : 1000.0,
					"style" : ""
				}

			}
, 			{
				"box" : 				{
					"fontsize" : 18.0,
					"id" : "obj-83",
					"maxclass" : "textbutton",
					"mode" : 1,
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "", "", "int" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1263.0, -18.0, 173.0, 43.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1226.0, -17.0, 173.0, 43.0 ],
					"style" : "",
					"text" : "Monitoring Off",
					"texton" : "Monitoring On"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-81",
					"maxclass" : "textbutton",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "", "", "int" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 1282.0, 46.0, 100.0, 20.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1226.0, 38.0, 100.0, 20.0 ],
					"style" : "",
					"text" : "manual update"
				}

			}
, 			{
				"box" : 				{
					"fontsize" : 20.0,
					"id" : "obj-71",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 1250.0, 960.0, 243.0, 51.0 ],
					"style" : "",
					"text" : "scroll down to view\nold-style watchdog list..."
				}

			}
, 			{
				"box" : 				{
					"fontface" : 1,
					"fontname" : "Arial",
					"fontsize" : 16.0,
					"id" : "obj-58",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 1269.0, 27.0, 254.0, 24.0 ],
					"presentation" : 1,
					"presentation_rect" : [ 1231.0, 120.0, 254.0, 24.0 ],
					"style" : "",
					"text" : "Master Show Automation"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-62",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 81.0, -23.0, 198.0, 22.0 ],
					"style" : "",
					"text" : "read floorplan-bothfloors_1200.png"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-63",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"patching_rect" : [ 19.0, -23.0, 60.0, 22.0 ],
					"style" : "",
					"text" : "loadbang"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-33",
					"linecount" : 2,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 957.0, 1130.0, 170.0, 33.0 ],
					"style" : "",
					"text" : "please don't touch this ^^^^\nwithout talking to chris clavio"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-14",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 0,
					"patcher" : 					{
						"fileversion" : 1,
						"appversion" : 						{
							"major" : 7,
							"minor" : 0,
							"revision" : 6,
							"architecture" : "x86",
							"modernui" : 1
						}
,
						"rect" : [ 413.0, 187.0, 749.0, 662.0 ],
						"bglocked" : 0,
						"openinpresentation" : 0,
						"default_fontsize" : 12.0,
						"default_fontface" : 0,
						"default_fontname" : "Arial",
						"gridonopen" : 1,
						"gridsize" : [ 15.0, 15.0 ],
						"gridsnaponopen" : 1,
						"objectsnaponopen" : 1,
						"statusbarvisible" : 2,
						"toolbarvisible" : 1,
						"lefttoolbarpinned" : 0,
						"toptoolbarpinned" : 0,
						"righttoolbarpinned" : 0,
						"bottomtoolbarpinned" : 0,
						"toolbars_unpinned_last_save" : 0,
						"tallnewobj" : 0,
						"boxanimatetime" : 200,
						"enablehscroll" : 1,
						"enablevscroll" : 1,
						"devicewidth" : 0.0,
						"description" : "",
						"digest" : "",
						"tags" : "",
						"style" : "",
						"subpatcher_template" : "",
						"boxes" : [ 							{
								"box" : 								{
									"id" : "obj-108",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 25.0, 359.0, 152.0, 22.0 ],
									"style" : "",
									"text" : "udpsend 10.42.112.4 7778"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-15",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patcher" : 									{
										"fileversion" : 1,
										"appversion" : 										{
											"major" : 7,
											"minor" : 0,
											"revision" : 6,
											"architecture" : "x86",
											"modernui" : 1
										}
,
										"rect" : [ 336.0, 231.0, 1078.0, 557.0 ],
										"bglocked" : 0,
										"openinpresentation" : 0,
										"default_fontsize" : 12.0,
										"default_fontface" : 0,
										"default_fontname" : "Arial",
										"gridonopen" : 1,
										"gridsize" : [ 15.0, 15.0 ],
										"gridsnaponopen" : 1,
										"objectsnaponopen" : 1,
										"statusbarvisible" : 2,
										"toolbarvisible" : 1,
										"lefttoolbarpinned" : 0,
										"toptoolbarpinned" : 0,
										"righttoolbarpinned" : 0,
										"bottomtoolbarpinned" : 0,
										"toolbars_unpinned_last_save" : 0,
										"tallnewobj" : 0,
										"boxanimatetime" : 200,
										"enablehscroll" : 1,
										"enablevscroll" : 1,
										"devicewidth" : 0.0,
										"description" : "",
										"digest" : "",
										"tags" : "",
										"style" : "",
										"subpatcher_template" : "",
										"boxes" : [ 											{
												"box" : 												{
													"id" : "obj-36",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 563.0, 158.0, 100.0, 22.0 ],
													"style" : "",
													"text" : "1 1"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-33",
													"maxclass" : "number",
													"numinlets" : 1,
													"numoutlets" : 2,
													"outlettype" : [ "", "bang" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 131.0, 463.0, 50.0, 22.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-34",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 135.0, 509.0, 122.0, 22.0 ],
													"style" : "",
													"text" : "/status $1"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-27",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 0,
													"patching_rect" : [ 318.0, 339.0, 100.0, 22.0 ],
													"style" : "",
													"text" : "print 2LDStatus"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-29",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 613.0, 92.0, 24.0, 24.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-25",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 0,
													"patching_rect" : [ 151.0, 429.0, 100.0, 22.0 ],
													"style" : "",
													"text" : "s relay2LDgui"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-51",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 770.3125, 46.0, 24.0, 24.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-49",
													"maxclass" : "newobj",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "bang" ],
													"patching_rect" : [ 770.3125, 94.0, 100.0, 22.0 ],
													"style" : "",
													"text" : "metro 500"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-45",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 814.3125, 258.0, 109.0, 22.0 ],
													"style" : "",
													"text" : "sprintf /status %i"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-44",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 4,
													"outlettype" : [ "", "", "", "" ],
													"patching_rect" : [ 770.3125, 218.0, 151.0, 22.0 ],
													"saved_object_attributes" : 													{
														"embed" : 0
													}
,
													"style" : "",
													"text" : "coll Panel-2LDmapping.txt"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-43",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 770.3125, 176.0, 100.0, 22.0 ],
													"style" : "",
													"text" : "sprintf /2LD-%i"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-42",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 0,
													"patching_rect" : [ 814.3125, 311.0, 100.0, 22.0 ],
													"style" : "",
													"text" : "print"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-31",
													"maxclass" : "newobj",
													"numinlets" : 5,
													"numoutlets" : 4,
													"outlettype" : [ "int", "", "", "int" ],
													"patching_rect" : [ 770.3125, 134.0, 100.0, 22.0 ],
													"style" : "",
													"text" : "counter 0 1 38"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-2",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 273.0, 282.0, 80.0, 22.0 ],
													"style" : "",
													"text" : "/2LD-38 1"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-16",
													"maxclass" : "newobj",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 273.0, 242.0, 80.0, 22.0 ],
													"style" : "",
													"text" : "sprintf %s %i"
												}

											}
, 											{
												"box" : 												{
													"checkedcolor" : [ 0.803922, 0.898039, 0.909804, 1.0 ],
													"id" : "obj-32",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 986.75, 428.0, 24.0, 24.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 9.0, 150.0, 24.0, 24.0 ],
													"style" : "",
													"uncheckedcolor" : [ 0.376471, 0.384314, 0.4, 1.0 ]
												}

											}
, 											{
												"box" : 												{
													"checkedcolor" : [ 0.803922, 0.898039, 0.909804, 1.0 ],
													"id" : "obj-30",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 951.0625, 428.0, 24.0, 24.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 151.75, 116.0, 24.0, 24.0 ],
													"style" : "",
													"uncheckedcolor" : [ 0.376471, 0.384314, 0.4, 1.0 ]
												}

											}
, 											{
												"box" : 												{
													"checkedcolor" : [ 0.803922, 0.898039, 0.909804, 1.0 ],
													"id" : "obj-28",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 915.375, 428.0, 24.0, 24.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 116.0625, 116.0, 24.0, 24.0 ],
													"style" : "",
													"uncheckedcolor" : [ 0.376471, 0.384314, 0.4, 1.0 ]
												}

											}
, 											{
												"box" : 												{
													"checkedcolor" : [ 0.803922, 0.898039, 0.909804, 1.0 ],
													"id" : "obj-26",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 879.6875, 428.0, 24.0, 24.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 80.375, 116.0, 24.0, 24.0 ],
													"style" : "",
													"uncheckedcolor" : [ 0.376471, 0.384314, 0.4, 1.0 ]
												}

											}
, 											{
												"box" : 												{
													"checkedcolor" : [ 0.803922, 0.898039, 0.909804, 1.0 ],
													"id" : "obj-24",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 844.0, 428.0, 24.0, 24.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 44.6875, 116.0, 24.0, 24.0 ],
													"style" : "",
													"uncheckedcolor" : [ 0.376471, 0.384314, 0.4, 1.0 ]
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-15",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 51.0, 67.0, 132.0, 22.0 ],
													"style" : "",
													"text" : "/2LD-19 1."
												}

											}
, 											{
												"box" : 												{
													"comment" : "",
													"id" : "obj-1",
													"maxclass" : "outlet",
													"numinlets" : 1,
													"numoutlets" : 0,
													"patching_rect" : [ 20.0, 478.0, 30.0, 30.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-100",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 395.75, 282.0, 143.0, 22.0 ],
													"style" : "",
													"text" : "/Panel-2LD/2LD-38 1"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-95",
													"maxclass" : "newobj",
													"numinlets" : 2,
													"numoutlets" : 2,
													"outlettype" : [ "", "" ],
													"patching_rect" : [ 273.0, 201.0, 79.0, 22.0 ],
													"style" : "",
													"text" : "route symbol"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-79",
													"maxclass" : "newobj",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 395.75, 242.0, 140.0, 22.0 ],
													"style" : "",
													"text" : "sprintf /Panel-2LD%s %i"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-105",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 4,
													"outlettype" : [ "", "", "", "" ],
													"patching_rect" : [ 273.0, 163.0, 151.0, 22.0 ],
													"saved_object_attributes" : 													{
														"embed" : 0
													}
,
													"style" : "",
													"text" : "coll Panel-2LDmapping.txt"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-98",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 81.666672, 277.0, 91.0, 22.0 ],
													"style" : "",
													"text" : "/relay 10 1"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-96",
													"maxclass" : "newobj",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 63.666668, 242.0, 109.0, 22.0 ],
													"style" : "",
													"text" : "sprintf /relay %i %i"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-94",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 2,
													"outlettype" : [ "", "int" ],
													"patching_rect" : [ 20.0, 128.0, 65.0, 22.0 ],
													"style" : "",
													"text" : "unpack s i"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-80",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 4,
													"outlettype" : [ "", "", "", "" ],
													"patching_rect" : [ 20.0, 163.0, 151.0, 22.0 ],
													"saved_object_attributes" : 													{
														"embed" : 0
													}
,
													"style" : "",
													"text" : "coll Panel-2LDmapping.txt"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-70",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 2,
													"outlettype" : [ "int", "int" ],
													"patching_rect" : [ 273.0, 128.0, 61.0, 22.0 ],
													"style" : "",
													"text" : "unpack i i"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-68",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 208.0, 128.0, 50.0, 22.0 ],
													"style" : "",
													"text" : "0 1"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-61",
													"linecount" : 4,
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 485.0, 114.0, 50.0, 62.0 ],
													"style" : "",
													"text" : "\"power supply YELLOW\""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-59",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 421.0, 114.0, 50.0, 22.0 ],
													"style" : "",
													"text" : "0"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-57",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 5,
													"outlettype" : [ "", "", "", "", "" ],
													"patching_rect" : [ 273.0, 67.0, 338.0, 22.0 ],
													"style" : "",
													"text" : "OSC-route /reply /temperatureSensor /powerFailure /status"
												}

											}
, 											{
												"box" : 												{
													"comment" : "",
													"id" : "obj-56",
													"maxclass" : "inlet",
													"numinlets" : 0,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 273.0, 18.0, 30.0, 30.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-5",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 0,
													"patching_rect" : [ 63.666668, 319.0, 152.0, 22.0 ],
													"style" : "",
													"text" : "udpsend 10.42.0.113 9999"
												}

											}
, 											{
												"box" : 												{
													"checkedcolor" : [ 0.803922, 0.898039, 0.909804, 1.0 ],
													"id" : "obj-23",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 808.3125, 428.0, 24.0, 24.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 9.0, 116.0, 24.0, 24.0 ],
													"style" : "",
													"uncheckedcolor" : [ 0.376471, 0.384314, 0.4, 1.0 ]
												}

											}
, 											{
												"box" : 												{
													"checkedcolor" : [ 0.803922, 0.898039, 0.909804, 1.0 ],
													"id" : "obj-22",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 772.625, 428.0, 24.0, 24.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 151.75, 81.0, 24.0, 24.0 ],
													"style" : "",
													"uncheckedcolor" : [ 0.376471, 0.384314, 0.4, 1.0 ]
												}

											}
, 											{
												"box" : 												{
													"checkedcolor" : [ 0.803922, 0.898039, 0.909804, 1.0 ],
													"id" : "obj-21",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 736.9375, 428.0, 24.0, 24.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 116.0625, 81.0, 24.0, 24.0 ],
													"style" : "",
													"uncheckedcolor" : [ 0.376471, 0.384314, 0.4, 1.0 ]
												}

											}
, 											{
												"box" : 												{
													"checkedcolor" : [ 0.803922, 0.898039, 0.909804, 1.0 ],
													"id" : "obj-20",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 701.25, 428.0, 24.0, 24.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 80.375, 81.0, 24.0, 24.0 ],
													"style" : "",
													"uncheckedcolor" : [ 0.376471, 0.384314, 0.4, 1.0 ]
												}

											}
, 											{
												"box" : 												{
													"checkedcolor" : [ 0.803922, 0.898039, 0.909804, 1.0 ],
													"id" : "obj-19",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 665.5625, 428.0, 24.0, 24.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 44.6875, 81.0, 24.0, 24.0 ],
													"style" : "",
													"uncheckedcolor" : [ 0.376471, 0.384314, 0.4, 1.0 ]
												}

											}
, 											{
												"box" : 												{
													"checkedcolor" : [ 0.803922, 0.898039, 0.909804, 1.0 ],
													"id" : "obj-18",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 629.875, 428.0, 24.0, 24.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 9.0, 81.0, 24.0, 24.0 ],
													"style" : "",
													"uncheckedcolor" : [ 0.376471, 0.384314, 0.4, 1.0 ]
												}

											}
, 											{
												"box" : 												{
													"checkedcolor" : [ 0.803922, 0.898039, 0.909804, 1.0 ],
													"id" : "obj-17",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 594.1875, 428.0, 24.0, 24.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 151.75, 47.0, 24.0, 24.0 ],
													"style" : "",
													"uncheckedcolor" : [ 0.376471, 0.384314, 0.4, 1.0 ]
												}

											}
, 											{
												"box" : 												{
													"checkedcolor" : [ 0.803922, 0.898039, 0.909804, 1.0 ],
													"id" : "obj-14",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 558.5, 428.0, 24.0, 24.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 116.0625, 47.0, 24.0, 24.0 ],
													"style" : "",
													"uncheckedcolor" : [ 0.376471, 0.384314, 0.4, 1.0 ]
												}

											}
, 											{
												"box" : 												{
													"checkedcolor" : [ 0.803922, 0.898039, 0.909804, 1.0 ],
													"id" : "obj-13",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 522.8125, 428.0, 24.0, 24.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 80.375, 47.0, 24.0, 24.0 ],
													"style" : "",
													"uncheckedcolor" : [ 0.376471, 0.384314, 0.4, 1.0 ]
												}

											}
, 											{
												"box" : 												{
													"checkedcolor" : [ 0.803922, 0.898039, 0.909804, 1.0 ],
													"id" : "obj-12",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 487.0, 428.0, 24.0, 24.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 44.5625, 47.0, 24.0, 24.0 ],
													"style" : "",
													"uncheckedcolor" : [ 0.376471, 0.384314, 0.4, 1.0 ]
												}

											}
, 											{
												"box" : 												{
													"checkedcolor" : [ 0.803922, 0.898039, 0.909804, 1.0 ],
													"id" : "obj-11",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 451.4375, 428.0, 24.0, 24.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 9.0, 47.0, 24.0, 24.0 ],
													"style" : "",
													"uncheckedcolor" : [ 0.376471, 0.384314, 0.4, 1.0 ]
												}

											}
, 											{
												"box" : 												{
													"checkedcolor" : [ 0.803922, 0.898039, 0.909804, 1.0 ],
													"id" : "obj-10",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 415.75, 428.0, 24.0, 24.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 151.75, 13.0, 24.0, 24.0 ],
													"style" : "",
													"uncheckedcolor" : [ 0.376471, 0.384314, 0.4, 1.0 ]
												}

											}
, 											{
												"box" : 												{
													"checkedcolor" : [ 0.803922, 0.898039, 0.909804, 1.0 ],
													"id" : "obj-9",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 380.0625, 428.0, 24.0, 24.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 116.0625, 13.0, 24.0, 24.0 ],
													"style" : "",
													"uncheckedcolor" : [ 0.376471, 0.384314, 0.4, 1.0 ]
												}

											}
, 											{
												"box" : 												{
													"checkedcolor" : [ 0.803922, 0.898039, 0.909804, 1.0 ],
													"id" : "obj-8",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 344.375, 428.0, 24.0, 24.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 80.375, 13.0, 24.0, 24.0 ],
													"style" : "",
													"uncheckedcolor" : [ 0.376471, 0.384314, 0.4, 1.0 ]
												}

											}
, 											{
												"box" : 												{
													"checkedcolor" : [ 0.803922, 0.898039, 0.909804, 1.0 ],
													"id" : "obj-7",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 308.6875, 428.0, 24.0, 24.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 44.6875, 13.0, 24.0, 24.0 ],
													"style" : "",
													"uncheckedcolor" : [ 0.376471, 0.384314, 0.4, 1.0 ]
												}

											}
, 											{
												"box" : 												{
													"checkedcolor" : [ 0.803922, 0.898039, 0.909804, 1.0 ],
													"id" : "obj-6",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 273.0, 428.0, 24.0, 24.0 ],
													"presentation" : 1,
													"presentation_rect" : [ 9.0, 13.0, 24.0, 24.0 ],
													"style" : "",
													"uncheckedcolor" : [ 0.376471, 0.384314, 0.4, 1.0 ]
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-4",
													"linecount" : 2,
													"maxclass" : "newobj",
													"numinlets" : 22,
													"numoutlets" : 22,
													"outlettype" : [ "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "" ],
													"patching_rect" : [ 273.0, 374.0, 768.4375, 35.0 ],
													"style" : "",
													"text" : "route /2LD-2 /2LD-4 /2LD-6 /2LD-7 /2LD-8 /2LD-9 /2LD-10 /2LD-11 /2LD-12 /2LD-13 /2LD-14 /2LD-15 /2LD-16 /2LD-17 /2LD-18 /2LD-19 /2LD-20 /2LD-21 /2LD-29 /2LD-36 /2LD-38"
												}

											}
, 											{
												"box" : 												{
													"comment" : "",
													"id" : "obj-3",
													"maxclass" : "inlet",
													"numinlets" : 0,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 20.0, 18.0, 30.0, 30.0 ],
													"style" : ""
												}

											}
 ],
										"lines" : [ 											{
												"patchline" : 												{
													"destination" : [ "obj-95", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-105", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-94", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-15", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-2", 1 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-16", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-25", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-16", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-27", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-16", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-4", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-16", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-15", 1 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-3", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-94", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-3", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-43", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-31", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-51", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-31", 2 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-34", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-33", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-5", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-34", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-10", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 4 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-11", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 5 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-12", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 6 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-13", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 7 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-14", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 8 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-17", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 9 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-18", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 10 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-19", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 11 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-20", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 12 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-21", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 13 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-22", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 14 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-23", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 15 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-24", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 16 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-26", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 17 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-28", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 18 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-30", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 19 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-32", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 20 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-6", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-7", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 1 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-8", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 2 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-9", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 3 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-44", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-43", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-45", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-44", 1 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-42", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-45", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-31", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-49", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-49", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-51", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-57", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-56", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-36", 1 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-57", 3 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-59", 1 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-57", 1 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-61", 1 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-57", 2 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-68", 1 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-57", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-70", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-57", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-105", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-70", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-16", 1 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-70", 1 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-79", 1 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-70", 1 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-1", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-79", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-100", 1 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-79", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-96", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-80", 1 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-80", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-94", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-96", 1 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-94", 1 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-16", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-95", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-79", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-95", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-5", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-96", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-98", 1 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-96", 0 ]
												}

											}
 ]
									}
,
									"patching_rect" : [ 184.0, 272.0, 114.0, 22.0 ],
									"saved_object_attributes" : 									{
										"description" : "",
										"digest" : "",
										"globalpatchername" : "",
										"style" : "",
										"tags" : ""
									}
,
									"style" : "",
									"text" : "p Panel2LD-routing"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-10",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patcher" : 									{
										"fileversion" : 1,
										"appversion" : 										{
											"major" : 7,
											"minor" : 0,
											"revision" : 6,
											"architecture" : "x86",
											"modernui" : 1
										}
,
										"rect" : [ 115.0, 107.0, 958.0, 559.0 ],
										"bglocked" : 0,
										"openinpresentation" : 0,
										"default_fontsize" : 12.0,
										"default_fontface" : 0,
										"default_fontname" : "Arial",
										"gridonopen" : 1,
										"gridsize" : [ 15.0, 15.0 ],
										"gridsnaponopen" : 1,
										"objectsnaponopen" : 1,
										"statusbarvisible" : 2,
										"toolbarvisible" : 1,
										"lefttoolbarpinned" : 0,
										"toptoolbarpinned" : 0,
										"righttoolbarpinned" : 0,
										"bottomtoolbarpinned" : 0,
										"toolbars_unpinned_last_save" : 0,
										"tallnewobj" : 0,
										"boxanimatetime" : 200,
										"enablehscroll" : 1,
										"enablevscroll" : 1,
										"devicewidth" : 0.0,
										"description" : "",
										"digest" : "",
										"tags" : "",
										"style" : "",
										"subpatcher_template" : "",
										"boxes" : [ 											{
												"box" : 												{
													"id" : "obj-35",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 533.1875, 171.0, 111.0, 22.0 ],
													"style" : "",
													"text" : "13 1"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-33",
													"maxclass" : "number",
													"numinlets" : 1,
													"numoutlets" : 2,
													"outlettype" : [ "", "bang" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 131.0, 463.0, 50.0, 22.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-30",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 135.0, 509.0, 122.0, 22.0 ],
													"style" : "",
													"text" : "/status $1"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-16",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 0,
													"patching_rect" : [ 318.0, 334.0, 100.0, 22.0 ],
													"style" : "",
													"text" : "print 2LCStatus"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-27",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 359.0, 114.0, 50.0, 22.0 ],
													"style" : "",
													"text" : "13 1"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-25",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 651.3125, 294.0, 94.0, 22.0 ],
													"style" : "",
													"text" : "/2LC/status 11"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-1",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 0,
													"patching_rect" : [ 151.0, 429.0, 100.0, 22.0 ],
													"style" : "",
													"text" : "s relay2LCgui"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-51",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 721.3125, 29.0, 24.0, 24.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-49",
													"maxclass" : "newobj",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "bang" ],
													"patching_rect" : [ 721.3125, 77.0, 100.0, 22.0 ],
													"style" : "",
													"text" : "metro 500"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-45",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 765.3125, 241.0, 136.0, 22.0 ],
													"style" : "",
													"text" : "sprintf /status %i"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-44",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 4,
													"outlettype" : [ "", "", "", "" ],
													"patching_rect" : [ 721.3125, 201.0, 151.0, 22.0 ],
													"saved_object_attributes" : 													{
														"embed" : 0
													}
,
													"style" : "",
													"text" : "coll Panel-2LCmapping.txt"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-43",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 721.3125, 159.0, 100.0, 22.0 ],
													"style" : "",
													"text" : "sprintf /2LC-%i"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-42",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 0,
													"patching_rect" : [ 765.3125, 294.0, 100.0, 22.0 ],
													"style" : "",
													"text" : "print"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-31",
													"maxclass" : "newobj",
													"numinlets" : 5,
													"numoutlets" : 4,
													"outlettype" : [ "int", "", "", "int" ],
													"patching_rect" : [ 721.3125, 117.0, 100.0, 22.0 ],
													"style" : "",
													"text" : "counter 0 1 22"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-26",
													"maxclass" : "newobj",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 273.0, 253.0, 80.0, 22.0 ],
													"style" : "",
													"text" : "sprintf %s %i"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-2",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 273.0, 295.0, 82.0, 22.0 ],
													"style" : "",
													"text" : "/2LC-22 1"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-24",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 45.0, 67.0, 118.0, 22.0 ],
													"style" : "",
													"text" : "/2LC-5 1."
												}

											}
, 											{
												"box" : 												{
													"comment" : "",
													"id" : "obj-15",
													"maxclass" : "outlet",
													"numinlets" : 1,
													"numoutlets" : 0,
													"patching_rect" : [ 20.0, 484.0, 30.0, 30.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-100",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 380.0625, 295.0, 148.0, 22.0 ],
													"style" : "",
													"text" : "/Panel-2LC/2LC-22 1"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-95",
													"maxclass" : "newobj",
													"numinlets" : 2,
													"numoutlets" : 2,
													"outlettype" : [ "", "" ],
													"patching_rect" : [ 273.0, 201.0, 79.0, 22.0 ],
													"style" : "",
													"text" : "route symbol"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-79",
													"maxclass" : "newobj",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 380.0625, 253.0, 140.0, 22.0 ],
													"style" : "",
													"text" : "sprintf /Panel-2LC%s %i"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-105",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 4,
													"outlettype" : [ "", "", "", "" ],
													"patching_rect" : [ 273.0, 163.0, 151.0, 22.0 ],
													"saved_object_attributes" : 													{
														"embed" : 0
													}
,
													"style" : "",
													"text" : "coll Panel-2LCmapping.txt"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-98",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 63.666668, 280.0, 91.0, 22.0 ],
													"style" : "",
													"text" : "/relay 2 1"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-96",
													"maxclass" : "newobj",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 63.666668, 242.0, 109.0, 22.0 ],
													"style" : "",
													"text" : "sprintf /relay %i %i"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-94",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 2,
													"outlettype" : [ "", "int" ],
													"patching_rect" : [ 20.0, 128.0, 65.0, 22.0 ],
													"style" : "",
													"text" : "unpack s i"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-80",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 4,
													"outlettype" : [ "", "", "", "" ],
													"patching_rect" : [ 20.0, 163.0, 151.0, 22.0 ],
													"saved_object_attributes" : 													{
														"embed" : 0
													}
,
													"style" : "",
													"text" : "coll Panel-2LCmapping.txt"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-70",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 2,
													"outlettype" : [ "int", "int" ],
													"patching_rect" : [ 273.0, 128.0, 61.0, 22.0 ],
													"style" : "",
													"text" : "unpack i i"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-68",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 202.0, 128.0, 50.0, 22.0 ],
													"style" : "",
													"text" : "11 1"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-61",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 485.0, 114.0, 142.0, 22.0 ],
													"style" : "",
													"text" : "\"power supply YELLOW\""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-59",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 421.0, 114.0, 50.0, 22.0 ],
													"style" : "",
													"text" : "0"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-57",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 6,
													"outlettype" : [ "", "", "", "", "", "" ],
													"patching_rect" : [ 273.0, 67.0, 396.0, 22.0 ],
													"style" : "",
													"text" : "OSC-route /reply /status /temperatureSensor /powerFailure /status"
												}

											}
, 											{
												"box" : 												{
													"comment" : "",
													"id" : "obj-56",
													"maxclass" : "inlet",
													"numinlets" : 0,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 273.0, 18.0, 30.0, 30.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-5",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 0,
													"patching_rect" : [ 63.666668, 319.0, 152.0, 22.0 ],
													"style" : "",
													"text" : "udpsend 10.42.0.112 9999"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-23",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 808.3125, 428.0, 24.0, 24.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-22",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 772.625, 428.0, 24.0, 24.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-21",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 736.9375, 428.0, 24.0, 24.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-20",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 701.25, 428.0, 24.0, 24.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-19",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 665.5625, 428.0, 24.0, 24.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-18",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 629.875, 428.0, 24.0, 24.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-17",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 594.1875, 428.0, 24.0, 24.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-14",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 558.5, 428.0, 24.0, 24.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-13",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 522.8125, 428.0, 24.0, 24.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-12",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 487.0, 428.0, 24.0, 24.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-11",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 451.4375, 428.0, 24.0, 24.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-10",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 415.75, 428.0, 24.0, 24.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-9",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 380.0625, 428.0, 24.0, 24.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-8",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 344.375, 428.0, 24.0, 24.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-7",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 308.6875, 428.0, 24.0, 24.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-6",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 273.0, 428.0, 24.0, 24.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-4",
													"linecount" : 2,
													"maxclass" : "newobj",
													"numinlets" : 17,
													"numoutlets" : 17,
													"outlettype" : [ "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "" ],
													"patching_rect" : [ 273.0, 362.0, 590.0, 35.0 ],
													"style" : "",
													"text" : "route /2LC-4 /2LC-5 /2LC-6 /2LC-7 /2LC-9 /2LC-11 /2LC-12 /2LC-13 /2LC-14 /2LC-15 /2LC-17 /2LC-18 /2LC-19 /2LC-20 /2LC-21 /2LC-22"
												}

											}
, 											{
												"box" : 												{
													"comment" : "",
													"id" : "obj-3",
													"maxclass" : "inlet",
													"numinlets" : 0,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 20.0, 18.0, 30.0, 30.0 ],
													"style" : ""
												}

											}
 ],
										"lines" : [ 											{
												"patchline" : 												{
													"destination" : [ "obj-95", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-105", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-94", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-24", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-1", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-26", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-16", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-26", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-2", 1 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-26", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-4", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-26", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-24", 1 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-3", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-94", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-3", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-5", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-30", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-43", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-31", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-51", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-31", 2 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-30", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-33", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-10", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 4 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-11", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 5 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-12", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 6 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-13", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 7 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-14", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 8 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-17", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 9 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-18", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 10 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-19", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 11 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-20", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 12 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-21", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 13 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-22", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 14 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-23", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 15 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-6", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-7", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 1 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-8", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 2 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-9", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 3 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-44", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-43", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-45", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-44", 1 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-25", 1 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-45", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-42", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-45", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-31", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-49", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-49", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-51", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-57", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-56", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-27", 1 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-57", 1 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-35", 1 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-57", 4 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-59", 1 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-57", 2 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-61", 1 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-57", 3 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-68", 1 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-57", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-70", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-57", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-105", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-70", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-26", 1 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-70", 1 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-79", 1 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-70", 1 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-100", 1 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-79", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-15", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-79", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-96", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-80", 1 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-80", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-94", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-96", 1 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-94", 1 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-26", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-95", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-79", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-95", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-5", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-96", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-98", 1 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-96", 0 ]
												}

											}
 ]
									}
,
									"patching_rect" : [ 104.333336, 219.0, 114.0, 22.0 ],
									"saved_object_attributes" : 									{
										"description" : "",
										"digest" : "",
										"globalpatchername" : "",
										"style" : "",
										"tags" : ""
									}
,
									"style" : "",
									"text" : "p Panel2LC-routing"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-5",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 320.0, 91.0, 300.0, 22.0 ],
									"style" : "",
									"text" : "/2LC/powerFailure \"power supply YELLOW\""
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-2",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 4,
									"outlettype" : [ "", "", "", "" ],
									"patching_rect" : [ 320.0, 126.0, 153.0, 22.0 ],
									"style" : "",
									"text" : "OSC-route /2LB /2LC /2LD"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-17",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 320.0, 18.0, 99.0, 22.0 ],
									"style" : "",
									"text" : "udpreceive 7779"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-14",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patcher" : 									{
										"fileversion" : 1,
										"appversion" : 										{
											"major" : 7,
											"minor" : 0,
											"revision" : 6,
											"architecture" : "x86",
											"modernui" : 1
										}
,
										"rect" : [ 123.0, 160.0, 1154.0, 695.0 ],
										"bglocked" : 0,
										"openinpresentation" : 0,
										"default_fontsize" : 12.0,
										"default_fontface" : 0,
										"default_fontname" : "Arial",
										"gridonopen" : 1,
										"gridsize" : [ 15.0, 15.0 ],
										"gridsnaponopen" : 1,
										"objectsnaponopen" : 1,
										"statusbarvisible" : 2,
										"toolbarvisible" : 1,
										"lefttoolbarpinned" : 0,
										"toptoolbarpinned" : 0,
										"righttoolbarpinned" : 0,
										"bottomtoolbarpinned" : 0,
										"toolbars_unpinned_last_save" : 0,
										"tallnewobj" : 0,
										"boxanimatetime" : 200,
										"enablehscroll" : 1,
										"enablevscroll" : 1,
										"devicewidth" : 0.0,
										"description" : "",
										"digest" : "",
										"tags" : "",
										"style" : "",
										"subpatcher_template" : "",
										"boxes" : [ 											{
												"box" : 												{
													"id" : "obj-33",
													"maxclass" : "number",
													"numinlets" : 1,
													"numoutlets" : 2,
													"outlettype" : [ "", "bang" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 131.0, 463.0, 50.0, 22.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-30",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 135.0, 509.0, 122.0, 22.0 ],
													"style" : "",
													"text" : "/status $1"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-28",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 648.25, 175.0, 132.75, 22.0 ],
													"style" : "",
													"text" : "3 1"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-27",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 0,
													"patching_rect" : [ 334.0, 326.0, 100.0, 22.0 ],
													"style" : "",
													"text" : "print 2LBStatus"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-24",
													"maxclass" : "button",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "bang" ],
													"patching_rect" : [ 210.0, 114.0, 24.0, 24.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-15",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 0,
													"patching_rect" : [ 151.0, 429.0, 100.0, 22.0 ],
													"style" : "",
													"text" : "s relay2LBgui"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-1",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 273.0, 293.0, 80.0, 22.0 ],
													"style" : "",
													"text" : "/2LB-21 1"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-2",
													"maxclass" : "newobj",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 273.0, 253.0, 80.0, 22.0 ],
													"style" : "",
													"text" : "sprintf %s %i"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-114",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 44.166668, 67.0, 148.0, 22.0 ],
													"style" : "",
													"text" : "/2LB-8 1."
												}

											}
, 											{
												"box" : 												{
													"comment" : "",
													"id" : "obj-110",
													"maxclass" : "outlet",
													"numinlets" : 1,
													"numoutlets" : 0,
													"patching_rect" : [ 20.0, 477.0, 30.0, 30.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-100",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 380.0625, 293.0, 139.0, 22.0 ],
													"style" : "",
													"text" : "/Panel-2LB/2LB-21 1"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-95",
													"maxclass" : "newobj",
													"numinlets" : 2,
													"numoutlets" : 2,
													"outlettype" : [ "", "" ],
													"patching_rect" : [ 273.0, 201.0, 79.0, 22.0 ],
													"style" : "",
													"text" : "route symbol"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-79",
													"maxclass" : "newobj",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 380.0625, 253.0, 139.0, 22.0 ],
													"style" : "",
													"text" : "sprintf /Panel-2LB%s %i"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-105",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 4,
													"outlettype" : [ "", "", "", "" ],
													"patching_rect" : [ 273.0, 163.0, 150.0, 22.0 ],
													"saved_object_attributes" : 													{
														"embed" : 0
													}
,
													"style" : "",
													"text" : "coll Panel-2LBmapping.txt"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-98",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 63.666668, 280.0, 91.0, 22.0 ],
													"style" : "",
													"text" : "/relay 9 1"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-96",
													"maxclass" : "newobj",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 63.666668, 242.0, 109.0, 22.0 ],
													"style" : "",
													"text" : "sprintf /relay %i %i"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-94",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 2,
													"outlettype" : [ "", "int" ],
													"patching_rect" : [ 20.0, 128.0, 65.0, 22.0 ],
													"style" : "",
													"text" : "unpack s i"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-80",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 4,
													"outlettype" : [ "", "", "", "" ],
													"patching_rect" : [ 20.0, 163.0, 150.0, 22.0 ],
													"saved_object_attributes" : 													{
														"embed" : 0
													}
,
													"style" : "",
													"text" : "coll Panel-2LBmapping.txt"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-70",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 2,
													"outlettype" : [ "int", "int" ],
													"patching_rect" : [ 273.0, 128.0, 61.0, 22.0 ],
													"style" : "",
													"text" : "unpack i i"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-68",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 353.0, 114.0, 50.0, 22.0 ],
													"style" : "",
													"text" : "10 1"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-61",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 485.0, 114.0, 142.0, 22.0 ],
													"style" : "",
													"text" : "\"power supply YELLOW\""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-59",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 421.0, 114.0, 50.0, 22.0 ],
													"style" : "",
													"text" : "0"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-57",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 5,
													"outlettype" : [ "", "", "", "", "" ],
													"patching_rect" : [ 273.0, 67.0, 452.25, 22.0 ],
													"style" : "",
													"text" : "OSC-route /reply /temperatureSensor /powerFailure /status"
												}

											}
, 											{
												"box" : 												{
													"comment" : "",
													"id" : "obj-56",
													"maxclass" : "inlet",
													"numinlets" : 0,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 273.0, 18.0, 30.0, 30.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-5",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 0,
													"patching_rect" : [ 63.666668, 319.0, 152.0, 22.0 ],
													"style" : "",
													"text" : "udpsend 10.42.0.111 9999"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-23",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 808.3125, 428.0, 24.0, 24.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-22",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 772.625, 428.0, 24.0, 24.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-21",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 736.9375, 428.0, 24.0, 24.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-20",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 701.25, 428.0, 24.0, 24.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-19",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 665.5625, 428.0, 24.0, 24.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-18",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 629.875, 428.0, 24.0, 24.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-17",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 594.1875, 428.0, 24.0, 24.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-14",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 558.5, 428.0, 24.0, 24.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-13",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 522.8125, 428.0, 24.0, 24.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-12",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 487.0, 428.0, 24.0, 24.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-11",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 451.4375, 428.0, 24.0, 24.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-10",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 415.75, 428.0, 24.0, 24.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-9",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 380.0625, 428.0, 24.0, 24.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-8",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 344.375, 428.0, 24.0, 24.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-7",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 308.6875, 428.0, 24.0, 24.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-6",
													"maxclass" : "toggle",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"parameter_enable" : 0,
													"patching_rect" : [ 273.0, 428.0, 24.0, 24.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-4",
													"linecount" : 2,
													"maxclass" : "newobj",
													"numinlets" : 17,
													"numoutlets" : 17,
													"outlettype" : [ "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "" ],
													"patching_rect" : [ 273.0, 368.0, 590.0, 35.0 ],
													"style" : "",
													"text" : "route /2LB-2 /2LB-5 /2LB-6 /2LB-7 /2LB-8 /2LB-9 /2LB-10 /2LB-11 /2LB-12 /2LB-13 /2LB-15 /2LB-17 /2LB-18 /2LB-19 /2LB-20 /2LB-21"
												}

											}
, 											{
												"box" : 												{
													"comment" : "",
													"id" : "obj-3",
													"maxclass" : "inlet",
													"numinlets" : 0,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 20.0, 18.0, 30.0, 30.0 ],
													"style" : ""
												}

											}
 ],
										"lines" : [ 											{
												"patchline" : 												{
													"destination" : [ "obj-95", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-105", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-94", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-114", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-1", 1 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-2", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-15", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-2", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-27", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-2", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-4", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-2", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-114", 1 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-3", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-94", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-3", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-5", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-30", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-30", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-33", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-10", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 4 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-11", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 5 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-12", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 6 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-13", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 7 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-14", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 8 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-17", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 9 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-18", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 10 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-19", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 11 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-20", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 12 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-21", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 13 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-22", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 14 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-23", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 15 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-6", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-7", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 1 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-8", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 2 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-9", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 3 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-57", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-56", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-24", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-57", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-28", 1 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-57", 3 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-59", 1 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-57", 1 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-61", 1 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-57", 2 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-68", 1 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-57", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-70", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-57", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-105", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-70", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-2", 1 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-70", 1 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-79", 1 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-70", 1 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-100", 1 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-79", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-110", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-79", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-96", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-80", 1 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-80", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-94", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-96", 1 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-94", 1 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-2", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-95", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-79", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-95", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-5", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-96", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-98", 1 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-96", 0 ]
												}

											}
 ]
									}
,
									"patching_rect" : [ 25.0, 184.0, 113.0, 22.0 ],
									"saved_object_attributes" : 									{
										"description" : "",
										"digest" : "",
										"globalpatchername" : "",
										"style" : "",
										"tags" : ""
									}
,
									"style" : "",
									"text" : "p Panel2LB-routing"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-13",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 200.0, 126.0, 82.0, 22.0 ],
									"style" : "",
									"text" : "/2LD-19 1."
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-12",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 111.0, 126.0, 82.0, 22.0 ],
									"style" : "",
									"text" : "/2LC-5 1."
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-11",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 25.0, 126.0, 79.0, 22.0 ],
									"style" : "",
									"text" : "/2LB-8 1."
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-9",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 4,
									"outlettype" : [ "", "", "", "" ],
									"patching_rect" : [ 25.333334, 91.0, 257.0, 22.0 ],
									"style" : "",
									"text" : "OSC-route /Panel-2LB /Panel-2LC /Panel-2LD"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-3",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 38.5, 55.0, 159.0, 22.0 ],
									"style" : "",
									"text" : "/Panel-2LC/2LC-5 1."
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-1",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 25.0, 18.0, 99.0, 22.0 ],
									"style" : "",
									"text" : "udpreceive 7777"
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"destination" : [ "obj-3", 1 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-1", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-9", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-1", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-108", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-10", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-108", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-14", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-108", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-15", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-2", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-17", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-5", 1 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-17", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-10", 1 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-2", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-14", 1 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-2", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-15", 1 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-2", 2 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-10", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-9", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-11", 1 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-9", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-12", 1 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-9", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-13", 1 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-9", 2 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-14", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-9", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-15", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-9", 2 ]
								}

							}
 ]
					}
,
					"patching_rect" : [ 1035.0, 1105.0, 90.0, 22.0 ],
					"saved_object_attributes" : 					{
						"description" : "",
						"digest" : "",
						"globalpatchername" : "",
						"style" : "",
						"tags" : ""
					}
,
					"style" : "",
					"text" : "p RelayControl"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-46",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "bang", "int" ],
					"patcher" : 					{
						"fileversion" : 1,
						"appversion" : 						{
							"major" : 7,
							"minor" : 0,
							"revision" : 6,
							"architecture" : "x86",
							"modernui" : 1
						}
,
						"rect" : [ 59.0, 104.0, 640.0, 480.0 ],
						"bglocked" : 0,
						"openinpresentation" : 0,
						"default_fontsize" : 12.0,
						"default_fontface" : 0,
						"default_fontname" : "Arial",
						"gridonopen" : 1,
						"gridsize" : [ 15.0, 15.0 ],
						"gridsnaponopen" : 1,
						"objectsnaponopen" : 1,
						"statusbarvisible" : 2,
						"toolbarvisible" : 1,
						"lefttoolbarpinned" : 0,
						"toptoolbarpinned" : 0,
						"righttoolbarpinned" : 0,
						"bottomtoolbarpinned" : 0,
						"toolbars_unpinned_last_save" : 0,
						"tallnewobj" : 0,
						"boxanimatetime" : 200,
						"enablehscroll" : 1,
						"enablevscroll" : 1,
						"devicewidth" : 0.0,
						"description" : "",
						"digest" : "",
						"tags" : "",
						"style" : "",
						"subpatcher_template" : "",
						"boxes" : [ 							{
								"box" : 								{
									"id" : "obj-11",
									"linecount" : 2,
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 267.0, 290.0, 150.0, 33.0 ],
									"style" : "",
									"text" : "refresh every 60 seconds for now"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-9",
									"maxclass" : "button",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"patching_rect" : [ 182.0, 404.0, 24.0, 24.0 ],
									"style" : ""
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-6",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 2,
									"outlettype" : [ "bang", "" ],
									"patching_rect" : [ 182.0, 359.0, 100.0, 22.0 ],
									"style" : "",
									"text" : "sel 60"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-4",
									"maxclass" : "button",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"patching_rect" : [ 214.0, 217.0, 24.0, 24.0 ],
									"presentation_rect" : [ 492.0, 188.0, 24.0, 24.0 ],
									"style" : ""
								}

							}
, 							{
								"box" : 								{
									"fontname" : "Arial",
									"fontsize" : 13.0,
									"format" : 6,
									"id" : "obj-39",
									"maxclass" : "flonum",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "", "bang" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 182.0, 318.0, 50.0, 23.0 ],
									"style" : ""
								}

							}
, 							{
								"box" : 								{
									"fontface" : 0,
									"fontname" : "Arial",
									"fontsize" : 13.0,
									"id" : "obj-5",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "bang", "int" ],
									"patching_rect" : [ 214.0, 250.0, 82.0, 23.0 ],
									"style" : "",
									"text" : "trigger b 10"
								}

							}
, 							{
								"box" : 								{
									"fontname" : "Arial",
									"fontsize" : 13.0,
									"format" : 6,
									"id" : "obj-33",
									"maxclass" : "flonum",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "", "bang" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 182.0, 189.0, 50.0, 23.0 ],
									"style" : ""
								}

							}
, 							{
								"box" : 								{
									"fontname" : "Arial",
									"fontsize" : 13.0,
									"id" : "obj-29",
									"maxclass" : "newobj",
									"numinlets" : 3,
									"numoutlets" : 1,
									"outlettype" : [ "float" ],
									"patching_rect" : [ 182.0, 290.0, 65.0, 23.0 ],
									"style" : "",
									"text" : "accum 0."
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-34",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "int", "int" ],
									"patching_rect" : [ 50.0, 127.0, 29.5, 22.0 ],
									"style" : "",
									"text" : "t i i"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-26",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 2,
									"outlettype" : [ "bang", "" ],
									"patching_rect" : [ 50.0, 152.0, 80.0, 22.0 ],
									"style" : "",
									"text" : "sel 1000"
								}

							}
, 							{
								"box" : 								{
									"fontface" : 0,
									"fontname" : "Arial",
									"fontsize" : 13.0,
									"id" : "obj-23",
									"maxclass" : "newobj",
									"numinlets" : 5,
									"numoutlets" : 4,
									"outlettype" : [ "int", "", "", "int" ],
									"patching_rect" : [ 50.0, 100.0, 122.0, 23.0 ],
									"presentation" : 1,
									"presentation_rect" : [ 298.0, 560.0, 142.0, 23.0 ],
									"style" : "",
									"text" : "counter 1 1000"
								}

							}
, 							{
								"box" : 								{
									"comment" : "",
									"id" : "obj-37",
									"maxclass" : "inlet",
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"patching_rect" : [ 50.0, 40.0, 30.0, 30.0 ],
									"style" : ""
								}

							}
, 							{
								"box" : 								{
									"comment" : "",
									"id" : "obj-42",
									"maxclass" : "outlet",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 48.0, 309.0, 30.0, 30.0 ],
									"style" : ""
								}

							}
, 							{
								"box" : 								{
									"comment" : "",
									"id" : "obj-43",
									"maxclass" : "outlet",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 83.0, 309.0, 30.0, 30.0 ],
									"style" : ""
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"destination" : [ "obj-34", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-23", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-5", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-26", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-39", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"midpoints" : [ 191.5, 314.0, 191.5, 314.0 ],
									"source" : [ "obj-29", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-6", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-29", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-29", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"midpoints" : [ 191.5, 215.0, 191.5, 215.0 ],
									"source" : [ "obj-33", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-26", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-34", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-43", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-34", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-23", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-37", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-5", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"midpoints" : [ 223.5, 242.0, 223.5, 242.0 ],
									"source" : [ "obj-4", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-29", 1 ],
									"disabled" : 0,
									"hidden" : 0,
									"midpoints" : [ 286.5, 275.0, 214.5, 275.0 ],
									"source" : [ "obj-5", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-29", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"midpoints" : [ 223.5, 275.0, 191.5, 275.0 ],
									"source" : [ "obj-5", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-33", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-6", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-42", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-6", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-9", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-6", 0 ]
								}

							}
 ]
					}
,
					"patching_rect" : [ 18.5, 1153.0, 97.0, 22.0 ],
					"saved_object_attributes" : 					{
						"description" : "",
						"digest" : "",
						"globalpatchername" : "",
						"style" : "",
						"tags" : ""
					}
,
					"style" : "",
					"text" : "p counterTimer"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-31",
					"maxclass" : "textbutton",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "", "", "int" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 129.0, 1153.0, 100.0, 20.0 ],
					"style" : "",
					"text" : "manual update"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-3",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "bang", "bang", "bang" ],
					"patching_rect" : [ 27.0, 1196.0, 100.0, 22.0 ],
					"style" : "",
					"text" : "t b b b"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-25",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"patching_rect" : [ 18.5, 1124.0, 89.0, 22.0 ],
					"style" : "",
					"text" : "metro 60"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-21",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patcher" : 					{
						"fileversion" : 1,
						"appversion" : 						{
							"major" : 7,
							"minor" : 0,
							"revision" : 6,
							"architecture" : "x86",
							"modernui" : 1
						}
,
						"rect" : [ 102.0, 172.0, 1544.0, 805.0 ],
						"bglocked" : 0,
						"openinpresentation" : 0,
						"default_fontsize" : 12.0,
						"default_fontface" : 0,
						"default_fontname" : "Arial",
						"gridonopen" : 1,
						"gridsize" : [ 15.0, 15.0 ],
						"gridsnaponopen" : 1,
						"objectsnaponopen" : 1,
						"statusbarvisible" : 2,
						"toolbarvisible" : 1,
						"lefttoolbarpinned" : 0,
						"toptoolbarpinned" : 0,
						"righttoolbarpinned" : 0,
						"bottomtoolbarpinned" : 0,
						"toolbars_unpinned_last_save" : 0,
						"tallnewobj" : 0,
						"boxanimatetime" : 200,
						"enablehscroll" : 1,
						"enablevscroll" : 1,
						"devicewidth" : 0.0,
						"description" : "",
						"digest" : "",
						"tags" : "",
						"style" : "",
						"subpatcher_template" : "",
						"boxes" : [ 							{
								"box" : 								{
									"id" : "obj-2",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "", "" ],
									"patching_rect" : [ 1262.3125, 105.0, 100.0, 22.0 ],
									"style" : "",
									"text" : "t s s"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-12",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "", "" ],
									"patching_rect" : [ 565.5, 352.0, 100.0, 22.0 ],
									"style" : "",
									"text" : "t s s"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-3",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patcher" : 									{
										"fileversion" : 1,
										"appversion" : 										{
											"major" : 7,
											"minor" : 0,
											"revision" : 6,
											"architecture" : "x86",
											"modernui" : 1
										}
,
										"rect" : [ 59.0, 104.0, 770.0, 478.0 ],
										"bglocked" : 0,
										"openinpresentation" : 0,
										"default_fontsize" : 12.0,
										"default_fontface" : 0,
										"default_fontname" : "Arial",
										"gridonopen" : 1,
										"gridsize" : [ 15.0, 15.0 ],
										"gridsnaponopen" : 1,
										"objectsnaponopen" : 1,
										"statusbarvisible" : 2,
										"toolbarvisible" : 1,
										"lefttoolbarpinned" : 0,
										"toptoolbarpinned" : 0,
										"righttoolbarpinned" : 0,
										"bottomtoolbarpinned" : 0,
										"toolbars_unpinned_last_save" : 0,
										"tallnewobj" : 0,
										"boxanimatetime" : 200,
										"enablehscroll" : 1,
										"enablevscroll" : 1,
										"devicewidth" : 0.0,
										"description" : "",
										"digest" : "",
										"tags" : "",
										"style" : "",
										"subpatcher_template" : "",
										"boxes" : [ 											{
												"box" : 												{
													"id" : "obj-14",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 2,
													"outlettype" : [ "", "" ],
													"patching_rect" : [ 76.0, 252.0, 33.0, 22.0 ],
													"style" : "",
													"text" : "t s s"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-13",
													"maxclass" : "newobj",
													"numinlets" : 2,
													"numoutlets" : 2,
													"outlettype" : [ "", "" ],
													"patching_rect" : [ 76.0, 222.0, 82.0, 22.0 ],
													"style" : "",
													"text" : "route ALARM"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-12",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 76.0, 189.0, 73.0, 22.0 ],
													"style" : "",
													"text" : "fromsymbol"
												}

											}
, 											{
												"box" : 												{
													"comment" : "",
													"id" : "obj-10",
													"maxclass" : "outlet",
													"numinlets" : 1,
													"numoutlets" : 0,
													"patching_rect" : [ 146.0, 286.0, 30.0, 30.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-7",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "bang" ],
													"patching_rect" : [ 193.0, 35.0, 60.0, 22.0 ],
													"style" : "",
													"text" : "loadbang"
												}

											}
, 											{
												"box" : 												{
													"fontface" : 0,
													"fontname" : "Verdana",
													"fontsize" : 9.873845,
													"id" : "obj-5",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 76.0, 162.0, 151.0, 20.0 ],
													"saved_object_attributes" : 													{
														"filename" : "watchGod_returnsNone.js",
														"parameter_enable" : 0
													}
,
													"style" : "",
													"text" : "js watchGod_returnsNone.js",
													"varname" : "js[1]"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-45",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 76.0, 126.0, 100.0, 22.0 ],
													"style" : "",
													"text" : "prepend exec"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-113",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 76.0, 92.0, 507.0, 22.0 ],
													"style" : "",
													"text" : "sprintf \\\"SELECT ID_NAME\\, ALARM\\, TIMESTAMP FROM alarms where ID_NAME like '%s' \\\""
												}

											}
, 											{
												"box" : 												{
													"fontname" : "Verdana",
													"fontsize" : 9.873845,
													"id" : "obj-119",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 193.0, 126.0, 478.0, 20.0 ],
													"style" : "",
													"text" : "opendb \"Macintosh HD:/Users/Aesir/Documents/watchdog/tcp_watchdog_server/alarmdb.db\""
												}

											}
, 											{
												"box" : 												{
													"comment" : "",
													"id" : "obj-8",
													"maxclass" : "inlet",
													"numinlets" : 0,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 76.0, 27.0, 30.0, 30.0 ],
													"style" : ""
												}

											}
 ],
										"lines" : [ 											{
												"patchline" : 												{
													"destination" : [ "obj-45", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-113", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-5", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-119", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-13", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-12", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-14", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-13", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-10", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-14", 1 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-5", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-45", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-12", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-5", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-119", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-7", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-113", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-8", 0 ]
												}

											}
 ]
									}
,
									"patching_rect" : [ 565.5, 309.0, 57.0, 22.0 ],
									"saved_object_attributes" : 									{
										"description" : "",
										"digest" : "",
										"globalpatchername" : "",
										"style" : "",
										"tags" : ""
									}
,
									"style" : "",
									"text" : "p alarmz"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-8",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "", "" ],
									"patching_rect" : [ 1117.5, 109.0, 33.0, 22.0 ],
									"style" : "",
									"text" : "t s s"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-6",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "", "" ],
									"patching_rect" : [ 997.571411, 109.0, 33.0, 22.0 ],
									"style" : "",
									"text" : "t s s"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-5",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "", "" ],
									"patching_rect" : [ 877.642883, 109.0, 33.0, 22.0 ],
									"style" : "",
									"text" : "t s s"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-4",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 50.0, 295.0, 244.0, 20.0 ],
									"style" : "",
									"text" : "if there's something after a slash it's a child"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-59",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 87.0, 48.0, 564.0, 20.0 ],
									"style" : "",
									"text" : "ID LOCATION TIMESTAMP UPTIME_SEC STATUS LAST_RESET DEVICE_TYPE "
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-1",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 9,
									"outlettype" : [ "", "", "", "", "", "", "", "", "" ],
									"patching_rect" : [ 50.0, 72.0, 1404.5, 22.0 ],
									"style" : "",
									"text" : "unjoin 8"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-28",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "", "" ],
									"patching_rect" : [ 398.0, 400.0, 100.0, 22.0 ],
									"style" : "",
									"text" : "t s s"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-31",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "int", "int" ],
									"patching_rect" : [ 761.214294, 109.0, 29.5, 22.0 ],
									"style" : "",
									"text" : "t i i"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-32",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "", "" ],
									"patching_rect" : [ 199.357147, 109.0, 33.0, 22.0 ],
									"style" : "",
									"text" : "t s s"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-7",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 3,
									"outlettype" : [ "", "", "" ],
									"patching_rect" : [ 50.0, 155.0, 218.571426, 22.0 ],
									"style" : "",
									"text" : "t s s s"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-67",
									"maxclass" : "newobj",
									"numinlets" : 10,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 458.0, 525.0, 858.5, 22.0 ],
									"style" : "",
									"text" : "join 10"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-66",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "", "" ],
									"patching_rect" : [ 636.785706, 109.0, 34.0, 22.0 ],
									"style" : "",
									"text" : "t s s"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-61",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 5,
									"outlettype" : [ "", "", "", "", "" ],
									"patching_rect" : [ 458.0, 472.0, 213.0, 22.0 ],
									"style" : "",
									"text" : "unjoin 4"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-60",
									"maxclass" : "newobj",
									"numinlets" : 4,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 458.0, 498.0, 164.5, 22.0 ],
									"style" : "",
									"text" : "sprintf pi%i%i%i%i:status"
								}

							}
, 							{
								"box" : 								{
									"fontface" : 0,
									"fontname" : "Arial",
									"fontsize" : 13.0,
									"id" : "obj-58",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 5,
									"outlettype" : [ "", "", "", "", "" ],
									"patching_rect" : [ 397.5, 443.0, 261.0, 23.0 ],
									"style" : "",
									"text" : "regexp (\\\\d+)\\\\.(\\\\d+)\\\\.(\\\\d+)\\\\.(\\\\d+)"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-56",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 50.0, 272.0, 52.0, 20.0 ],
									"style" : "",
									"text" : "children"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-54",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 6,
									"outlettype" : [ "", "", "", "", "", "" ],
									"patching_rect" : [ 110.5, 213.0, 200.875, 22.0 ],
									"style" : "",
									"text" : "unjoin 5"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-45",
									"maxclass" : "newobj",
									"numinlets" : 10,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 120.5, 386.0, 133.5, 22.0 ],
									"style" : "",
									"text" : "join 10"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-38",
									"maxclass" : "newobj",
									"numinlets" : 5,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 110.5, 244.0, 164.5, 22.0 ],
									"style" : "",
									"text" : "sprintf pi%i%i%i%i:%s:status"
								}

							}
, 							{
								"box" : 								{
									"fontface" : 0,
									"fontname" : "Arial",
									"fontsize" : 13.0,
									"id" : "obj-36",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 5,
									"outlettype" : [ "", "", "", "", "" ],
									"patching_rect" : [ 50.0, 184.0, 261.0, 23.0 ],
									"style" : "",
									"text" : "regexp (\\\\d+)\\\\.(\\\\d+)\\\\.(\\\\d+)\\\\.(\\\\d+)/(.+)"
								}

							}
, 							{
								"box" : 								{
									"comment" : "",
									"id" : "obj-16",
									"maxclass" : "inlet",
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 50.0, 7.0, 30.0, 30.0 ],
									"style" : ""
								}

							}
, 							{
								"box" : 								{
									"comment" : "",
									"id" : "obj-17",
									"maxclass" : "outlet",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 119.6875, 627.0, 30.0, 30.0 ],
									"style" : ""
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"destination" : [ "obj-2", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-1", 7 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-31", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-1", 3 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-32", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-1", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-5", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-1", 4 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-6", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-1", 5 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-66", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-1", 2 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-7", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-1", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-8", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-1", 6 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-45", 8 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-12", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-67", 8 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-12", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-1", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-16", 0 ],
									"watchpoint_flags" : 1,
									"watchpoint_id" : 3
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-45", 9 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-2", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-67", 9 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-2", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-58", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-28", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-67", 1 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-28", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-12", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-3", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-45", 4 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-31", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-67", 4 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-31", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-45", 2 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-32", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-67", 2 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-32", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-28", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-36", 3 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-54", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-36", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-45", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-38", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-17", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-45", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-45", 5 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-5", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-67", 5 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-5", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-38", 4 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-54", 4 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-38", 3 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-54", 3 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-38", 2 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-54", 2 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-38", 1 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-54", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-38", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-54", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-61", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-58", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-45", 6 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-6", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-67", 6 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-6", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-67", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-60", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-60", 3 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-61", 3 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-60", 2 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-61", 2 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-60", 1 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-61", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-60", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-61", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-45", 3 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-66", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-67", 3 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-66", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-17", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-67", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-3", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-7", 2 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-36", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-7", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-45", 1 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-7", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-45", 7 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-8", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-67", 7 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-8", 1 ]
								}

							}
 ],
						"styles" : [ 							{
								"name" : "AudioStatus_Menu",
								"default" : 								{
									"bgfillcolor" : 									{
										"type" : "color",
										"color" : [ 0.294118, 0.313726, 0.337255, 1 ],
										"color1" : [ 0.454902, 0.462745, 0.482353, 0.0 ],
										"color2" : [ 0.290196, 0.309804, 0.301961, 1.0 ],
										"angle" : 270.0,
										"proportion" : 0.39,
										"autogradient" : 0
									}

								}
,
								"parentstyle" : "",
								"multi" : 0
							}
 ]
					}
,
					"patching_rect" : [ 81.5, 1270.5, 100.0, 22.0 ],
					"saved_object_attributes" : 					{
						"description" : "",
						"digest" : "",
						"globalpatchername" : "",
						"style" : "",
						"tags" : ""
					}
,
					"style" : "",
					"text" : "p unjoinRejoin"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-5",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"patching_rect" : [ 28.0, 1267.0, 39.0, 22.0 ],
					"style" : "",
					"text" : "t l l"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-27",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "", "int" ],
					"patcher" : 					{
						"fileversion" : 1,
						"appversion" : 						{
							"major" : 7,
							"minor" : 0,
							"revision" : 6,
							"architecture" : "x86",
							"modernui" : 1
						}
,
						"rect" : [ 159.0, 162.0, 1238.0, 828.0 ],
						"bglocked" : 0,
						"openinpresentation" : 0,
						"default_fontsize" : 12.0,
						"default_fontface" : 0,
						"default_fontname" : "Arial",
						"gridonopen" : 1,
						"gridsize" : [ 15.0, 15.0 ],
						"gridsnaponopen" : 1,
						"objectsnaponopen" : 1,
						"statusbarvisible" : 2,
						"toolbarvisible" : 1,
						"lefttoolbarpinned" : 0,
						"toptoolbarpinned" : 0,
						"righttoolbarpinned" : 0,
						"bottomtoolbarpinned" : 0,
						"toolbars_unpinned_last_save" : 0,
						"tallnewobj" : 0,
						"boxanimatetime" : 200,
						"enablehscroll" : 1,
						"enablevscroll" : 1,
						"devicewidth" : 0.0,
						"description" : "",
						"digest" : "",
						"tags" : "",
						"style" : "",
						"subpatcher_template" : "",
						"boxes" : [ 							{
								"box" : 								{
									"fontname" : "Verdana",
									"fontsize" : 9.873845,
									"id" : "obj-12",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 379.0, 172.0, 482.0, 20.0 ],
									"style" : "",
									"text" : "closedb \"Macintosh HD:/Users/Aesir/Documents/watchdog/tcp_watchdog_server/demosdb.db\""
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-14",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 199.0, 482.0, 50.0, 22.0 ],
									"style" : "",
									"text" : "zlclear"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-1",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 191.0, 442.0, 100.0, 22.0 ],
									"style" : "",
									"text" : "print"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-7",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 815.5, 633.0, 100.0, 22.0 ],
									"style" : "",
									"text" : "fromsymbol"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-13",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 347.0, 535.0, 50.0, 22.0 ],
									"style" : "",
									"text" : "317"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-18",
									"linecount" : 2,
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 301.0, 745.0, 22.0, 35.0 ],
									"style" : "",
									"text" : "\"0\""
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-16",
									"linecount" : 2,
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 220.699997, 733.0, 22.0, 35.0 ],
									"style" : "",
									"text" : "\"0\""
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-11",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 461.0, 721.0, 56.0, 22.0 ],
									"style" : "",
									"text" : "\"0\""
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-6",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 559.600037, 633.0, 59.0, 22.0 ],
									"style" : "",
									"text" : "tosymbol"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-5",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 536.0, 714.0, 132.0, 22.0 ],
									"style" : "",
									"text" : "\"0\""
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-10",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 644.900024, 633.0, 84.0, 22.0 ],
									"style" : "",
									"text" : "tosymbol"
								}

							}
, 							{
								"box" : 								{
									"comment" : "",
									"id" : "obj-9",
									"maxclass" : "inlet",
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"patching_rect" : [ 364.0, 40.0, 30.0, 30.0 ],
									"style" : ""
								}

							}
, 							{
								"box" : 								{
									"annotation" : "",
									"comment" : "joined relevent database results",
									"hint" : "",
									"id" : "obj-3",
									"maxclass" : "outlet",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 49.5, 787.0, 30.0, 30.0 ],
									"style" : ""
								}

							}
, 							{
								"box" : 								{
									"comment" : "result number",
									"id" : "obj-2",
									"maxclass" : "outlet",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 921.0, 665.0, 30.0, 30.0 ],
									"style" : ""
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-65",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 293.0, 583.0, 172.0, 20.0 ],
									"style" : "",
									"text" : "number of devices in database"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-105",
									"maxclass" : "newobj",
									"numinlets" : 8,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 49.5, 749.0, 82.0, 22.0 ],
									"style" : "",
									"text" : "join 8"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-115",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 474.300018, 633.0, 73.0, 22.0 ],
									"style" : "",
									"text" : "fromsymbol"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-116",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 389.0, 633.0, 73.0, 22.0 ],
									"style" : "",
									"text" : "fromsymbol"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-118",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 218.400009, 633.0, 59.0, 22.0 ],
									"style" : "",
									"text" : "tosymbol"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-4",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 133.100006, 633.0, 59.0, 22.0 ],
									"style" : "",
									"text" : "tosymbol"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-139",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 49.5, 633.0, 73.0, 22.0 ],
									"style" : "",
									"text" : "fromsymbol"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-142",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 16,
									"outlettype" : [ "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "int" ],
									"patcher" : 									{
										"fileversion" : 1,
										"appversion" : 										{
											"major" : 7,
											"minor" : 0,
											"revision" : 6,
											"architecture" : "x86",
											"modernui" : 1
										}
,
										"rect" : [ 34.0, 504.0, 1553.0, 539.0 ],
										"bglocked" : 0,
										"openinpresentation" : 0,
										"default_fontsize" : 12.0,
										"default_fontface" : 0,
										"default_fontname" : "Arial",
										"gridonopen" : 1,
										"gridsize" : [ 15.0, 15.0 ],
										"gridsnaponopen" : 1,
										"objectsnaponopen" : 1,
										"statusbarvisible" : 2,
										"toolbarvisible" : 1,
										"lefttoolbarpinned" : 0,
										"toptoolbarpinned" : 0,
										"righttoolbarpinned" : 0,
										"bottomtoolbarpinned" : 0,
										"toolbars_unpinned_last_save" : 0,
										"tallnewobj" : 0,
										"boxanimatetime" : 200,
										"enablehscroll" : 1,
										"enablevscroll" : 1,
										"devicewidth" : 0.0,
										"description" : "",
										"digest" : "",
										"tags" : "",
										"style" : "",
										"subpatcher_template" : "",
										"boxes" : [ 											{
												"box" : 												{
													"id" : "obj-31",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 1216.0, 165.0, 50.0, 22.0 ],
													"style" : "",
													"text" : "14"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-13",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 1204.0, 115.0, 73.0, 22.0 ],
													"style" : "",
													"text" : "fromsymbol"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-27",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 1124.0, 115.0, 73.0, 22.0 ],
													"style" : "",
													"text" : "fromsymbol"
												}

											}
, 											{
												"box" : 												{
													"comment" : "",
													"id" : "obj-26",
													"maxclass" : "outlet",
													"numinlets" : 1,
													"numoutlets" : 0,
													"patching_rect" : [ 576.0, 199.0, 30.0, 30.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-25",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 1044.0, 115.0, 73.0, 22.0 ],
													"style" : "",
													"text" : "fromsymbol"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-24",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 969.0, 115.0, 73.0, 22.0 ],
													"style" : "",
													"text" : "fromsymbol"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-23",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 894.0, 115.0, 73.0, 22.0 ],
													"style" : "",
													"text" : "fromsymbol"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-22",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 819.0, 115.0, 73.0, 22.0 ],
													"style" : "",
													"text" : "fromsymbol"
												}

											}
, 											{
												"box" : 												{
													"comment" : "",
													"id" : "obj-17",
													"maxclass" : "outlet",
													"numinlets" : 1,
													"numoutlets" : 0,
													"patching_rect" : [ 535.0, 199.0, 30.0, 30.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"comment" : "",
													"id" : "obj-19",
													"maxclass" : "outlet",
													"numinlets" : 1,
													"numoutlets" : 0,
													"patching_rect" : [ 497.0, 199.0, 30.0, 30.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"comment" : "",
													"id" : "obj-20",
													"maxclass" : "outlet",
													"numinlets" : 1,
													"numoutlets" : 0,
													"patching_rect" : [ 456.0, 199.0, 30.0, 30.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"comment" : "",
													"id" : "obj-21",
													"maxclass" : "outlet",
													"numinlets" : 1,
													"numoutlets" : 0,
													"patching_rect" : [ 417.0, 199.0, 30.0, 30.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"comment" : "",
													"id" : "obj-15",
													"maxclass" : "outlet",
													"numinlets" : 1,
													"numoutlets" : 0,
													"patching_rect" : [ 375.0, 199.0, 30.0, 30.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-14",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 744.0, 115.0, 73.0, 22.0 ],
													"style" : "",
													"text" : "fromsymbol"
												}

											}
, 											{
												"box" : 												{
													"comment" : "",
													"id" : "obj-12",
													"maxclass" : "outlet",
													"numinlets" : 1,
													"numoutlets" : 0,
													"patching_rect" : [ 334.0, 199.0, 30.0, 30.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-11",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 669.0, 115.0, 73.0, 22.0 ],
													"style" : "",
													"text" : "fromsymbol"
												}

											}
, 											{
												"box" : 												{
													"comment" : "",
													"id" : "obj-10",
													"maxclass" : "outlet",
													"numinlets" : 1,
													"numoutlets" : 0,
													"patching_rect" : [ 293.0, 199.0, 30.0, 30.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-7",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 581.0, 115.0, 73.0, 22.0 ],
													"style" : "",
													"text" : "fromsymbol"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-38",
													"maxclass" : "newobj",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "int" ],
													"patching_rect" : [ 1299.375, 203.0, 29.5, 22.0 ],
													"style" : "",
													"text" : "+ 1"
												}

											}
, 											{
												"box" : 												{
													"comment" : "",
													"id" : "obj-37",
													"maxclass" : "outlet",
													"numinlets" : 1,
													"numoutlets" : 0,
													"patching_rect" : [ 254.0, 199.0, 30.0, 30.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"comment" : "",
													"id" : "obj-36",
													"maxclass" : "outlet",
													"numinlets" : 1,
													"numoutlets" : 0,
													"patching_rect" : [ 220.0, 199.0, 30.0, 30.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"comment" : "",
													"id" : "obj-35",
													"maxclass" : "outlet",
													"numinlets" : 1,
													"numoutlets" : 0,
													"patching_rect" : [ 186.0, 199.0, 30.0, 30.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"comment" : "",
													"id" : "obj-34",
													"maxclass" : "outlet",
													"numinlets" : 1,
													"numoutlets" : 0,
													"patching_rect" : [ 152.0, 199.0, 30.0, 30.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"comment" : "",
													"id" : "obj-33",
													"maxclass" : "outlet",
													"numinlets" : 1,
													"numoutlets" : 0,
													"patching_rect" : [ 118.0, 199.0, 30.0, 30.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"comment" : "",
													"id" : "obj-32",
													"maxclass" : "outlet",
													"numinlets" : 1,
													"numoutlets" : 0,
													"patching_rect" : [ 84.0, 199.0, 30.0, 30.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-18",
													"maxclass" : "message",
													"numinlets" : 2,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 417.0, 424.0, 266.0, 22.0 ],
													"style" : "",
													"text" : "TIMESTAMP \"Jun 27, 2015 14:58:09\""
												}

											}
, 											{
												"box" : 												{
													"comment" : "",
													"id" : "obj-9",
													"maxclass" : "outlet",
													"numinlets" : 1,
													"numoutlets" : 0,
													"patching_rect" : [ 1299.375, 251.0, 30.0, 30.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"comment" : "",
													"id" : "obj-8",
													"maxclass" : "outlet",
													"numinlets" : 1,
													"numoutlets" : 0,
													"patching_rect" : [ 50.0, 199.0, 30.0, 30.0 ],
													"style" : ""
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-6",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 500.0, 115.0, 73.0, 22.0 ],
													"style" : "",
													"text" : "fromsymbol"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-5",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 425.0, 115.0, 73.0, 22.0 ],
													"style" : "",
													"text" : "fromsymbol"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-4",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 350.0, 115.0, 73.0, 22.0 ],
													"style" : "",
													"text" : "fromsymbol"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-3",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 275.0, 115.0, 73.0, 22.0 ],
													"style" : "",
													"text" : "fromsymbol"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-2",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 200.0, 115.0, 73.0, 22.0 ],
													"style" : "",
													"text" : "fromsymbol"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-1",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 125.0, 115.0, 73.0, 22.0 ],
													"style" : "",
													"text" : "fromsymbol"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-122",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 50.0, 115.0, 73.0, 22.0 ],
													"style" : "",
													"text" : "fromsymbol"
												}

											}
, 											{
												"box" : 												{
													"id" : "obj-90",
													"maxclass" : "newobj",
													"numinlets" : 1,
													"numoutlets" : 20,
													"outlettype" : [ "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "" ],
													"patching_rect" : [ 134.5, 29.0, 1220.535767, 22.0 ],
													"style" : "",
													"text" : "unjoin 19"
												}

											}
, 											{
												"box" : 												{
													"comment" : "",
													"id" : "obj-124",
													"maxclass" : "inlet",
													"numinlets" : 0,
													"numoutlets" : 1,
													"outlettype" : [ "" ],
													"patching_rect" : [ 50.0, 40.0, 30.0, 30.0 ],
													"style" : ""
												}

											}
 ],
										"lines" : [ 											{
												"patchline" : 												{
													"destination" : [ "obj-32", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-1", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-12", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-11", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-8", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-122", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-90", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-124", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-15", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-14", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-33", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-2", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-21", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-22", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-20", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-23", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-19", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-24", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-17", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-25", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-26", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-27", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-34", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-3", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-9", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-38", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-35", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-4", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-36", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-5", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-37", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-6", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-10", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-7", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-1", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-90", 1 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-11", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-90", 8 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-122", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-90", 0 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-13", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-90", 15 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-14", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-90", 9 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-2", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-90", 2 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-22", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-90", 10 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-23", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-90", 11 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-24", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-90", 12 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-25", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-90", 13 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-27", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-90", 14 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-3", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-90", 3 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-38", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-90", 18 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-4", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-90", 4 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-5", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-90", 5 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-6", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-90", 6 ]
												}

											}
, 											{
												"patchline" : 												{
													"destination" : [ "obj-7", 0 ],
													"disabled" : 0,
													"hidden" : 0,
													"source" : [ "obj-90", 7 ]
												}

											}
 ]
									}
,
									"patching_rect" : [ 50.0, 527.0, 241.0, 22.0 ],
									"saved_object_attributes" : 									{
										"description" : "",
										"digest" : "",
										"globalpatchername" : "",
										"style" : "",
										"tags" : ""
									}
,
									"style" : "",
									"text" : "p unjoinjoin"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-151",
									"maxclass" : "newobj",
									"numinlets" : 11,
									"numoutlets" : 11,
									"outlettype" : [ "", "", "", "", "", "", "", "", "", "", "" ],
									"patching_rect" : [ 47.800007, 605.0, 872.0, 22.0 ],
									"style" : "",
									"text" : "route ID_NAME DESCRIPTION TIMESTAMP UPTIME UPTIME_SEC STATUS DEVICE_TYPE LAST_RESET_TIMESTAMP LAST_RESET_SEC DEVICE_NAME"
								}

							}
, 							{
								"box" : 								{
									"fontface" : 0,
									"fontname" : "Arial",
									"fontsize" : 13.0,
									"id" : "obj-152",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 2,
									"outlettype" : [ "", "" ],
									"patching_rect" : [ 50.0, 481.0, 75.0, 23.0 ],
									"style" : "",
									"text" : "zl group 19"
								}

							}
, 							{
								"box" : 								{
									"fontface" : 0,
									"fontname" : "Verdana",
									"fontsize" : 9.873845,
									"id" : "obj-157",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 50.0, 410.0, 147.0, 20.0 ],
									"saved_object_attributes" : 									{
										"filename" : "watchGod.js",
										"parameter_enable" : 0
									}
,
									"style" : "",
									"text" : "js watchGod.js",
									"varname" : "js"
								}

							}
, 							{
								"box" : 								{
									"fontname" : "Verdana",
									"fontsize" : 9.873845,
									"id" : "obj-23",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 50.0, 116.0, 346.0, 20.0 ],
									"style" : "",
									"text" : "exec \"SELECT * FROM devices ORDER BY ID_NAME, DEVICE_TYPE\""
								}

							}
, 							{
								"box" : 								{
									"fontname" : "Verdana",
									"fontsize" : 9.873845,
									"id" : "obj-119",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 364.0, 72.0, 482.0, 20.0 ],
									"style" : "",
									"text" : "opendb \"Macintosh HD:/Users/Aesir/Documents/watchdog/tcp_watchdog_server/demosdb.db\""
								}

							}
, 							{
								"box" : 								{
									"comment" : "",
									"id" : "obj-8",
									"maxclass" : "inlet",
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"patching_rect" : [ 50.0, 40.0, 30.0, 30.0 ],
									"style" : ""
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"destination" : [ "obj-105", 5 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-10", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-3", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-105", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-105", 4 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-115", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-105", 3 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-116", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-105", 2 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-118", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-157", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-119", 0 ],
									"watchpoint_flags" : 1,
									"watchpoint_id" : 7
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-157", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-12", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-105", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-139", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-152", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-14", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-13", 1 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-142", 15 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-151", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-142", 14 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-151", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-142", 13 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-151", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-142", 12 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-151", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-142", 11 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-151", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-142", 10 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-151", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-142", 9 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-151", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-142", 8 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-151", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-142", 7 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-151", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-142", 6 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-151", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-142", 5 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-151", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-142", 4 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-151", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-142", 3 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-151", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-142", 2 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-151", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-142", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-151", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-142", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-2", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"midpoints" : [ 281.5, 596.5, 930.5, 596.5 ],
									"source" : [ "obj-142", 15 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-10", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-151", 7 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-115", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-151", 5 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-116", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-151", 4 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-118", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-151", 2 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-139", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-151", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-16", 1 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-151", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-4", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-151", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-5", 1 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-151", 6 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-6", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-151", 6 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-7", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-151", 9 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-142", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-152", 0 ],
									"watchpoint_flags" : 1,
									"watchpoint_id" : 8
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-152", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-157", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-157", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-23", 0 ],
									"watchpoint_flags" : 1,
									"watchpoint_id" : 9
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-105", 1 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-4", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-18", 1 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-4", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-105", 6 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-6", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-11", 1 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-6", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-105", 7 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-7", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-23", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-8", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-119", 0 ],
									"disabled" : 0,
									"hidden" : 0,
									"source" : [ "obj-9", 0 ]
								}

							}
 ]
					}
,
					"patching_rect" : [ 27.0, 1233.0, 197.0, 22.0 ],
					"saved_object_attributes" : 					{
						"description" : "",
						"digest" : "",
						"globalpatchername" : "",
						"style" : "",
						"tags" : ""
					}
,
					"style" : "",
					"text" : "p DatabaseQuery"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-70",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"patching_rect" : [ 81.5, 1294.5, 100.0, 22.0 ],
					"style" : "",
					"text" : "pattrhub"
				}

			}
, 			{
				"box" : 				{
					"background" : 1,
					"id" : "obj-66",
					"ignoreclick" : 1,
					"maxclass" : "fpic",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "jit_matrix" ],
					"patching_rect" : [ 32.0, -43.5, 1219.0, 987.0 ],
					"pic" : "floorplan-bothfloors_1200.png",
					"presentation" : 1,
					"presentation_rect" : [ 30.0, -39.0, 1200.0, 923.0 ]
				}

			}
, 			{
				"box" : 				{
					"alpha" : 0.3,
					"background" : 1,
					"data" : [ 24700, "png", "IBkSG0fBZn....PCIgDQRA..ALB..Dv7HX....vZdrm.....DLmPIQEBHf.B7g.YHB..f.PRDEDU3wI68dGXTbklt2OcUpa0cqVYj.EPAjDIiAiwXiw.FCFL3fHmCRBrIZlYuyF7c1YlOuyL6bmY1c+tyNyfS3.fMNgwIbffS3DFiMNfwFLfDAKDBDHPnPKoVcW2+fUXgnCmp5ppy4sr98WyXJ59k2pOOm2pNuOmiMYYYEXx3INIro0LBDumXM6uZMSSdaCyboe.NWc94cnnZRMY634ejQBWwJy6PgYpq9VvsMm2Kj+4xxh6+VxNCm3oefaBwHKw6PgYptllvjK6CX5ZMpbOWxVkNydQJgH.fm9kNBIEh..tm4U.oDh.PXEhDcV1BJjTBQ..qYCGl2gf4KFkY5NvztibM6u1nhZp0KdtW8n7NLzD42SW3Nu0r4cXnJp7jMDwqwuewbhgAz2DvnGdO3cXnJNX4mGu46TESWqQVQpoKFsjETHbXmVyZ7XO8gQysv6nPabuk0aXylMdGFphoeOeDuCAMyJKsHxkuW8ZOHuCA.XxhQ8sPO3VGYll4WYTSEG6B3MeW1l0Pz35FTRXXCIcdGFph8t+Z4cHnYF8M1MLv9kBuCCUwN+7Sic+UrkyM52SmoJFQwYoW8ZOHBDfVUxA.HIE.2aY8l2ggpPQQAK4ed2Lcsh1KvVVVAKujh3cXnJTTTvCtNwnpH.STLZDCMEL3AjpY80oK7YeUM3S+xyw6vPSba2bFnn7Sj2ggpXG6rZdGBZloNwrQ1Y3g2ggp30e6JwgOZje+b.li3uoHFIIE.qnT5MK8CrtCw6vPS3vNvRleg7NLTEs4O.9k+wuloqUzpJxsKIT1rKf2ggpvaK9we3u9s7NLtLLEwnhGe1H2ri2L9pzM15NpBG5HMx6vPSLyhyAo2M27NLTEiXRam2gflojYjORLdZ0pJO6KeDluVyR72vEib4zFV7bn0rFszpegnuKzBIFuLV3L5EuCCUQid8w70JZUE08tYGyr373cXnJp87MKj+91vEil+TyCojjSi9qQW4EdsigSelV4cXnIV7bJ.w4xNuCCUwXmw6v6PPyrzETD4ZUkG+YKm4q0LE+MzrXpIaGydJzZV55puEr9Wf8RXEIxNCmXRSnm7NLTEUWSSLeshVUQEkebX72LsZUkiUY83Eeief2gQPwPEitm4U.b5fdyZzj2.7NLzDTzFBr5GJQDqdCNZ1h+F1ubopMDdksVIuCCMAUsg.qHZUEMrgjBF50jFuCCUwW7MmAe3mVCSWKOx2FlXDEavwGXcGB98SqXtcVUYzaV5E9y2ESWmnIDIIE.qpL50fiq3W947NLBKFhXDUsgvGrqyv6vPSL5araX.8kd1PfpbGiMKjWOSf2ggpX6uO6VZhWh+5tXDUsgfnXVP0BEsgPf.Avu3e6KX5ZEsphbF6EeWnThV8E.2++02v6vHhn6hQT0FBe62WOuCCMAEsgvvKltM33bmRdH0jcw6vPU7huwwX9Z4o3utJFQUaH7vOk30.Xr.Usg.qHZUEkbhxXNSIedGFph5anE7Werum2gASnqhQTzFBuzadbT4Ial2gglfh1P3Vl1aw6PPyb2ysP31YL7NLTEq84EOaeDJzMwHJZCgFZpUrtmuBdGFZBpZCAVg2CL5L4lsKT73oUqpbhpaDOyKeTltVQHeqahQTzFBqeiGA0UuXt8kFInnMDt84uCdGBZlUTRgPRhV46G5Io0tNgtjcopMD1zqebdGFZBpZCAVQDlktiL3AjHFw0SqFJ86NXs3s+.11enDk7stHFs7RJhb1PXMa3vnU1MKtPwpVD8ZvwYsrOloqSTFXzQnVqp..rneAa6XlhDQsBx.5aB3lGV20iXwz3fkedrscbJdGFZhgMjTvPFHsrgvvtysx6PPyLtQlF5agIw6vPU7A6h8cLSQR7OpEinnMDnZCNRUaHvJhz.C..6wnfkUBspJxueE7u7u+U7NLzDQkXDUsgvd9l53cXnInnMDtw6Za7NDzLS+NyA8HMZ0pJad6r+dPEMweMKFQUaHP0phnpMDXEQafQBdjPoyhVspRid8g+7CredGFZhzRwt1EinnMDd82tRbrJ8x6vPSPQaHLpoPWaeT5r5E731AuCCUwF1D68LmnI9uj4Wn1Di73ll1P3wdFZ1fiojTLjzFBrhnMvHyzcfod64w6vPUTSsdYtaqEs7cg44FSbLYoMwnRlI8rgvy9xGAm8bzbs7W7bJfb1PXby98X55DsAF..KcgEA6wPqEkQD2f8YkkuvKtHXpVLp6cyNl9clmADRFGm8bdwS+Rzbeslp1Pfpz+h7fwNhL3cXnJJ+n0gWa6mfoqUzD+G5fR9R68YpVLhh1P3welxQyr+TCBEqrzhHmMDl1c+gLcch1.C.ZtCkNu68S3cHnIjjBfUsnebQvT0uxonMDN5ObA7ZuMayZHZL3AjHtogRqFJkxM33Hu9TwftJZcDr+oeIa6o0.hm3+DtkLQA48i68YpRLhh1P3AV2gPf.zpxh1gZ1PfxM3nrrBVAAy2+7eyd3cXnIb33J26yXdTJEsgvW7MmA67yqk2gglfh1PfxM3XwiOajSlzpUU1x6xdE+hl3+rKNGjVJWdqpvjXDUsg.UavQpZCAVQzFX31kD4NB1at0.328W1GuCCMQxIJi4O8qrgRYRLhh1PX6ueU36KmlqpCEsgvMMI5VUzBlVtH4DoUqprwWktM3XYyJ368YQTLhp1Pfp8cAUsg.qHZCLRKE6XlShV46yUWK3AWOa+9Vzx24joSL4IjSP+yhnXDEsgvld8ihpqoUdGFZhxlcAjyFBicFuCSWmnMv.3huDUJdDrSUVdIEAY4fuHXg8t.Usgv52HMavwLS2AlxDyk2ggpfxKke61PfRb7pZf4cnTQS7ef8KALxaHzspRXEitm4ROaH7DOWEnglX2s3hDKqjdSNaHvJh1.C.fUTJ8ZvwYtjOh2gflIRsFTHEixMaW3NGG8rgvKu0ef2ggln+E4Ai4ln09rLkqJZnCJYbCClVspxW+smk4qUzD+ukaJMz+dG989rPJFQQaH7PO4gfOezZlt1gh1PfUDsAFc1FBT.EEErz66y3cXnIraWAKegQNeGT0FJZCg8cfZw68wr2Z7hDTzFBTtpnNaCAJv67Qmj4qUzD+mxD5IxpGwEwqKnhQTzFBOv5n0YDU6PUaHvJh1.ifYCAQGesofe8edu7NLzDdhSBKZ1r05DWgXz3GU5jyFBu+tNE169u.uCCMwjm.8rg.q19PzDh..lyjx8JrgfnyK8lGk4qUzx4kNydg38vVCkdYhQ1iQAKkgmsSjvueE7PqmlUE41kDJaVzpgRo7imkbhxXdSiVspRCM0J9Kq46Y5ZEMgndjlCLs6f8VU4xDilwckK4rgvqr0iiJOI6mg6hDTzFBrhnMv.flGA625LeWdGBZlkL+BU0de1ktxD7HgRlIsl0nQu9Ha2nRQaHP4phxISmn3wGbaHHpTcMMw70JZh+8o.0u2mcIwHJZCgMroJPc06m2gglfh1PfUDsAF.g2FBhJStrOf2gflQKsphD.MsgvoOSS34dU1Ov5DInnMDnbUQCreIfQMLZ0PoG3vmm4qUzD+G90kBt1qtap9umD.MsgvZ1vgQqz7v9fj1PfUDsAF.fbM3H.Po+C6h2gflPRJflaMHIJZCgCcj5v1de1aBLQBJZCAVqJRDEhF6HhrMDDM9ncWMyWqnkyKd7YibyNdM82Uhh1P3AVKM2WqopMDnJ1sqfkt.ZkuCDH.9m9ceESWqnID4LVDU6XlRTyFB6ZOmFe1WeNdGFZBJZCAJ2fiSch4vjMDDI171qj2gflYdSMejRRN07eeRUdghhBdv0Sy80ZJZCAJ+Rq8DmDJaVzpUUZp41veZ0eGSWqnI9mZx1i589LRIFsk28Dn7i4k2gglfh1PfUDsAF.pyFBhBiY5uMuCAMy8LuBfqXiteGPFwnlakt6q0ImnLl+z5pAGMKTqMDDAN64XeRVQS7O+bbg67Vi989LxHF8buREnlZo4Z4u34T.b6hV6XlrhnMv.P81PPD3NVv6y6PPyrhRzmEAiD2wp87MiM7hGk2gglfh1PfxUEoEaHvap3XruiSHZh+C4pSDC+5RWW9rHgXzS7rU.uMSykXlh1PfUDsAF.zbGybtqbm7NDzL54delvKFc7pZ.a9sn4xcRQaHP4FbTq1Pfm7YeE66NohVN+1Fc2QuKP+16yDdwnG3I9d32OsloqcV0h6CuCAUAke7rnwFB7BEEErpe8dX5ZEMgHG10+VUQnEi9x8cV7QeVs7NLzDicDog9WDs1wLYEQafAPzYCAdw1e+p3cHnYlYw5+QvtvJFonnfUuVZ1fiTzFBTtpHWNsEU1PfGzpu.39+u9FltVQS7Ow3kwBmg92pJBqXza+gUgCb3F3cXnInnMDXEQafAvEOB1iFaHvCF0T1NuCAMyhlcuLjcLSgTLxWaJXMOEMavQJZCAJWUjdXCAyl5puEluVQS7O6LbhIOQioUUDRwnW5MNJp5zsx6vPSPQaHvJh1.C.8wFBlM21bdOdGBZlksfBQLxFirgvIF0PSsh0swJ3cXnInnMDn7R4meO0GaHXlT4IY+UOHZ47Az2DvnGtw0pJBmXz5d9JvEZH.uCCMAEsg.kgh6XlS+d9HdGBZlUVZQFZ9VnF4T0oZBa50o49ZMEsg.kqJROsgfYwd2O6sohnkyG8M1MLv9Yr6XlBkXzZdpCBesQqY5ZGpYCAJ+RqAn4Qv9R9m2MSWqnIDIKqfkWhw2pJBiXzAN74wa8gr2Z7hDTzFBrhnMv.P+sgfYvN1I66q0hFSchYiryv3OB1EFwn+9iy1Q3qnAEsg.kqJxg8KthNTh17G.+x+3Wyz0JZh+tcIgxls4zPoBgXzGs6pwW8cruMJHRPQaHvJh1.CfKZCgz6FsNB1GwjnaCNVxLxGIFu4zpJbWLJPf.3AV6g3cXnInnMDnbUQFkMDLRZzK6aHfhl3e26lcLyhyyz993tXzl2dk33U0LuCCMAEsg.qHZCL.LNaHXjL1Y7N7NDzL2y7KxTaUEtJF0TysgG6YnosOnnMDn7R4aj1Pvn3zmoIluVQKmWT9wgILZysUU3pXzS+hGAmqN+7LDzLTyFBT9wy.LVaHXTTboe.uCAMiQ2fiACtc28rmyKdtW8n75qOpfh1PfUDsYnALdaHXDbniTGyWqnkyG1PRAC8ZL+ifctIFslMbXzL6lWVnnqFbzbgGyRGsrfU8ILcchlPjjT.rRSnAGC52MO9Rq3XW.u46Ryc4tqaPIggMDZYCAVQzFX.XN1PPugxh+29XxD8J2D3x2MWDidf0eHDH.sd9eftZvQyFyxFB5IJJreJ1HZh+NikuGA6lthvm8U0fcsGZtuVOtQkAJJ+D4cXXHHZCL.LOaHnmbi2013cHnYl8jxColL+NB1MUwHEEE7.qilM3HEsg.kWJeyzFB5Edag8UFVzx4ImnLl2z3aqpXphQacGUgCcjFMyuRcCpYCAJ+3Y.lqMDzKtko8V7NDzL28bKDtcx2ifcSSLpkV8i0rAZ1fiTzFBrhnMCMf4aCA8fZOO6tHPzx44lsKT734eqpXZhQuvqcLb5yPy805EOmBHkMDndUQKcAlqMDzCt84uCltNQSHB.XEkTHjj3e91Thf5puEr9W3HlwWktS1Y3DSZB8j2gggfHNvnn7o2Nl4wprddGBZlAOfDwHtdwngRMEwn09bkil7Ry80ZpYCApWUDEavwYsrOloqSDE+EoVUwvGkU4Ia.uzVpzn+ZLDnnMDXEQbfAurgPz.kE+G2HSC8sPwYGyzvEidn0eH32Osloqcn1rzTdo74oMDzJTtAGsGiBVVIhSUQ.FrXzd2esXGexYLxuBCCJZCAJCOsgfVgxM33zuybPORSrZUECSLhxM3HEsg.kqJh21PPKzpO1eGnhVNOAORnzYIdsphgIFsicVM12An49ZM0rg.keuE.WbGyjm1PPKLpoP2805RmUufG2N3cXbEXHhQs4O.d3mhlM3HEsg.qHZyPCbQaHPscLy5af889FQKmmY5NvTu873cXDTLDwnWYKGGUdRZtuVSMaHP8phDAaHnVF2reOltNQSHB.XoKrHXOFwbQYzcwnFZpU7DOWE58Gqo.Esg.qHhCLDEaHnFNQ0zzak..8sPOXriHCdGFgDcWL5o1zQPc0Sy80ZpYCApWUjnXCA0vzt6OjoqSDE+E8cnTc8WBUWSSXia9354GooAEsg.qHhCLDIaHvJTV7eDCMEL3AjJuCivhtJFslMbXzJ6mYcBEc0filKhjMDzaDsbtrrBV4h5CuCiHhtIFcvxOO11NNkd8wYpPMaHP4YnADOaHvBTNmW73yF4jo32pJ5lXzpW6A0qOJSEIo.XUkQqFbjUDsYnADSaHDI76mt19vsKIxbDrqKhQ67yOM1y2v94DkHwcL1rPd8jN1PfxyPCHl1PHRbSSht19XASKWjbhznUUhZwn.ABfGb8zrpHmwdwSFVqHh1Lz.hqMDBGM5k8WBpnkySKE6XlShN46nVL5MdmSfibbu5QrX5PMaHP8phDUaHDNF6LdGltNQSHB3h98yoC5z5DQUj5sE+3Qe5x0qXwTgh1PfUDwAFhrMDBE0TKMmjE.nv7biINlr3cXnJhJwnm8kOBN64n4Z4SMaHP8kxWjsgPn3tV36yz0Ih47kuPZ0pJ.QgXTsmuY7zuDM2WqolMDn9imI51PHXP4b9PGTxj6HX+q+1ypcwnG6oOLZlcyKKTPQaHvBh3Lz..+rEI11PHZPzx4RRAvpVDsZUEEEErz66yfldNkiUY830d6S.Nb5XG0PMaHP4YnA.F40mJFzUI11PnyP4b9DtkLQA4Qmif8Nlq0jZxpW6AQf.zSHBv5ZCAQaFZfKZCgUPr7Mk2Wqc3fV6XlcVzW0JJew2bFryOuVcKfLSnlMDn7Lz.zwFBcDJuuVO6hyAokBcZUkNipDiTTTHqsOnnMDXEQaFZ.ZYCg1o4Vo69ZcxIJi4Oc5zfiAahVUIFs82uJ78kSyMWJpYCApuT9TxFBsynmJa6q0hXNurYQqif8fAyhQs5K.VyFn49ZMEsg.kgZ1P.f1ORb1Y3DSdB4v6vfYBUtlYwnM85GEUWSq5V.YlPMaHP8phnlMDTChXNe4kTDjkoeqSvzuXpugVv52HMavQpYCAJOCM.Msg.ky4CreIfadXcm2gAyDtbMShQOwyUAZnI1e4dhDTzFBrfHNCM.Msg.qHh4bpsCkFNhnXzIptQ7xa8GLiXQ2o+EQKaHP4YnAnoMDnbN+Vtozv.5KcNB1iTtNhhQOzSdH3yGMUdE8SCAshHNCMUsg.qHZ4b61UvxWHcx2rH5GVwn8cfZw68w0naAjYB0rg.kmgFfd1P.f8FbTzDh..lxD5IxpGww6vPWIjhQJJJ3AV2gLyXQ2fh1PfUDwAFTyFB..9Zi8phDM73VBKZ1zo0IXch1PJF8965TXu6+B5V.YlPMaHP8kxmh1PXjSltUEUxLyGw6gVMTJKDTwH+9UvCsdZVUD0rg.0e7LpYCA.Zmy6QZNvzuy73cXvLpIWGTwnWYqGGUdxl0s.xLgh1PfEDwYnArF1PHTHh47kL+BI0QvNqHKKekhQM50GV6ySy80ZpYCAJOCM.PNYRKaH.P6bdeJfVGA6p80ObEhQaXSUfyUme8MpLIrp1PPDmgF3hMTpUvFBACQLmSoVUQKh9W1H2Zp0KdtMebcKfLSnlMDn7Lz.zyFB.zNmO7qKEbsWc23cXn6zQQ+KSLZMa3vnUZ5EVrhRoyrFpAQbFZ.fUsHqiMD5LhVNWRJ.o1gR0pn+kDiJ+n0gs9dUoaAjYxPGTx3FFbZ7NLXFpuT92xMkF5euoiMD.ncN+tt0rPtYGOuCCcmNmqujXze+INDI2WqonMDnLTyFB.W7HXmp3LVf6ddzogRilGEVB.XW64z3y95yoaAjYB0rg.kmgFfl1PX3ES2cvw4M07QJI4j2ggtSvx0RJJJ3gdRZ1fiTyFBT9EnB.3INZYCA.ZmySMY6j5HXOZmnUZKu6IvgOZS5YLYZLmIkK4rg.KHhyPC.TxLrl1P.PLy42y7J.thU7hKiBIptuVmbhxXdSy5MqgnB0rg..sy44lsKbGi050pJgSzWplZ8oWwioxhmi0zFBh3Lz.VWaH.Hl476srdSlifc8RzmF+qsSjSlNQwimN1PfxyPCPOaH.P6b9Pt5DwvuNZsiYxBQRzmjhQVkSCgNiHNCM.srgfZQDy4+TnAGCFjSLZf8KALpg0CdGFLC0WJeJZCAJmyusQ2cz6BnyQvNqvRtlbhQTpAGo7iJ.POaH.P6btC6+ztUUHkXzXGA8rg.KHhyPCXcsg.fXlymYwz5HXmUXMWSFwH61UvRWPWUEYVPMaH.P6bdhwKiELcqWqpnFQexHFM0IlC4rg.KHhyPCXcsg.fXlyWzro0QvtQ.IDi7DmDJaVVuYMDUnlMD.ncNO6LbhIOQqWqpnVQeRHFU5L6kkzFBh3Lz.VaaHHh47ksfBQLxjXnngJ5Gid7g32ev2lZ0ia78HMGXZ2QtQ8miYAkWVY.f7ygV1P.f147Az2DvnGNcZUEVQK45nRLJThPc9OOZ9Q.krg.keTg1YEkPGaHXEXkkRmcLSi922ZVLJRBQr92KbBUTzFBrfHNCM.Msg.kqJZz2X2v.6WWspR6DCqhJc7KPsBQg65CW0STxFBVgph5pAGMOjkUvxKoqVUoivbkQZsRHsBEsg.KXjyPGMu6NqpMD.Dyphl5DyFYmAcNB1YknIWqKu.a8.+98+iGlaDyFB5wrFFoXejd2cTyFB.heNObCJc6RBkMaq2QvdzJ5KLhQcjhGe1VRaHz4aVlc0lgBqpMD.3WNObS.TxLxGIFu0qUUhVDNwHWNsgEOGq2rF.7W7oiUe1NIFuLV3Lrt6q07Nm2YRuaNvLtKqWqp.D84ZgYMbaePxbmRdVVaHHhrnY2KK4NlonPmGftj4WHh0g38NrBFl8BDHLhQ.zyFBTd0b.nmMD.ncNun7iCSXzVuVUQuf6OlV+J5hm4Y4miaL9QkIYrg.EGTzdtF.n246A25n5AJ+n0i9T.MN2413lOBuCAMQu6kGbU8NAbK2TOvAq3BjHeyieeycwnCVQCHVG1PoyJeX2NMDhnJGrhF.vEMd7cO2BwPuF5bjf+Q69T3+6Z9ddGFpFYYYTyYaFi3FJBCYfox6vQn4RhQs+NaLqW3WGeQpS3Vx.ImnSLv9Qi9bgZUE04WZ8ccqYgaZnzQHB.3e528k7NDzLS51xFtcw848YFd866Kkg30pNjTBxXbiJCxHDQEBUOez8t4fT6g3..63SNEuCAUS64+bxxIF1PRCWce6522QBSWttyCRl9clChqqYMtDFc2BOy6JGLv9SmAFGr7Kf+2+AispHiLmO6IkKhkHF8FfuU8qIU.YYYUWIUvtg2yLchQd8cGElu0qAGUKlgkE5SuhCC8ZniEaJ+n0iiWUCFxmsYjuGT+S.CnOIa3eO5E790Ov0RRl2TyCNbX8l0PD8BE.v7mQuPA4I9B+G+DMB..61kvu9OuWl+6IR4ca1BfEN87gc6RHmrrVaWx5cdt8BaTsRP6ABqAjrrbPu1A0+DvfGPpPRR7ckekmrItOqQzxMNjTPuyOAdGFLgjjMHIYCe49NCy+cDIgH.facj8.YmoGxHDwyee2tFgppLRM2vC20ZyV.T1r5ExNCZ3GpXUQ0ah1fB.fXhQAkLi7IU9NPf.3O922OSWunkycFKv7lRdp52MTAiLWyrXTvBhf0N.rDricDcG8JWZLKM.vcUxN3cHDUb6iIKjIgNYUjjrgs89Uy6vPyLkI1SjRxNQpISCyvJJU8GQwHVDWTiZoc6.kNqBHyMJ0fnMCM.PbtsgEL8bIU9tM+AvpehCxz0JZ47jSLFLyhyiT4aVwny0gsNRi3Kel2YNH8Tco6etFEhxrFZk4M07QhwSGiG2XSsgIU56y6vPyT5rx2R1pJlgnePyZF0WbRIHg4Ms7IyFruZPzlgF.n6cyNl9cjKhyMcFbTeisv70JZ477x1IJdb8DNHhq7EMtB6fXjrnYW.73lNaWEhzrFZgktfBgSSv3w98qno+dxx+3Jo19mwjK6C0kXhGrxR6MjIx4eFf3866XLqunbxzIl7Dx8x9AXWXbbwSVkrLkCz.83dprrMTwwtfJtdwZBfqaPIggOzty6vfYDwW+foIiu7RJhTBQh1rFpEJcxpzNyck6j2gflfZ6Y6pAy722lhXz0z+DHk4LEwYMTCT7jU4y9pZX9ZEsI.F2nx.Eku3uGE0Nh5uuMEwnUtn9XFeMlNh1fB.ZNKshhBV0udOLcshVN2gcfks.ZcxpvJlct1vEiF6HRC8uH53RbQcVCVghmrJ23csMdGBZlYVbNH8tQiNaGPr+8sgJFY2tBV5BnyoloZPzlgFfdmrJ..szJ669ChVNmhmrJrBOx0FpXzTmXNHKBYCAQdVCVX9SkdmrJ27TeKdGBZlEOmBH0IqhnunLFlXjm3jPYyhNmzGpAQaFZfKdxpLqISq7cc0S2FbL6LbhIMgdx6vvRggIFU5L6Eh2Cc7minOqQj3dlWAj4jUocts47d7NDzLKaAEhX5pAG0M762uwHFkY5NvztCq4oloHR98zEtyaMadGFphJOI66fih1D.CnuIfQO7tZUE8FCQLZIKnvt7elIBEavwoeOeDSWmHlyWYoEQt7MKvyph.L.wn9VnGbqijNmZlTYViPw0MnjvvFR57NLTE6c+0x6PPyL5araXf8KEdGFLCk98stKFQwYoYAQbFZp1fiK4ed2LcshVNWVVAKujtZUE8jNtwLpqhQiXnofAO.5bpYRoYMBF21MSKaH.P6FbbpSLajcFd3cXvLT6225lXjjT.rhRo0rzrhnMCMvEsgvRlOsrgPa9Cv70JZ4b2tjPYylVMTJqHBUEAnihQTyFBh9RcFInlMD..Fwj1NuCAMSIyHejX7c0pJFI5hXD0rg.0Jesi4G9Wm...H.jDQAQ0PQaHznWeLeshz.DfKtiYNyhyi2ggkhfcHvpKhQTzFBrfnMnncnlMD..F6LdGdGBZlktfhHUqpPwph.zAwnTS1Nl8TnyrzTupHJZCgpqoIluVQa.RQ4GGF+M2UqpnmDrph.zAwn6YdE.mccX0YZPMaH..L4x9.ltNQLm2UCNpuDJgHfnTLhZ1PfByZDNnlMD..NX4mm2gflYXCIELzqIMdGFLC0+8cTIF0UCNZtrpxn2rzK7muKltNQKmKIE.qprtZvQ8jvUUDPTHFQMaHP0WpW6L5araX.8kN1P.f1yTeGiMKjWOoyQvNky0silDinnMDnLTzFBABP2FbzYrW7cgZEQTqJBPihQTyFBTupHpYCA.fgWLcavw4Nk7PpIa8NB1E0ee2NpVLhZ1Pf5kuRQaH3sE5tuVmbhxXNSgN6XlT322rTUDPGNdqYEi1FBJPAtSpd3N4K.mIz.b3pYDSr9fM4.vFTfheYDvuD70hCzR8wglq2Mp+LIC+sDcspenFTzu9KgQOVYLjqSFETfDxHaaviGfXi0FZoYETeC.m7DJnhxCfubO9w6uC+Xe6k8GQIRPAaHz46Y+voOCNRUI.2wYCxx.M1fBpudEbxpBfuaeAv2rW+XquoOT4OnsiEaij6dtEB2NU8vBgGQSzOXXSVVl4eQjX7x3EdzQZHc+qbLshTxsZjXVmF1isMU+2uoyGGN6QxBMble7k7plYM53MKmNAleI1wcuLGn28Q8OI6wOV.73qoU7DOpOzH6angWhZaJ7d76X6ounoZU2w+T+FW3WUq8+VCSUed.Q+8rc+osg+1++sh270YuRJfHmezSBUdIR4SVHfea.A.76OF3uE6nUuNg25cilpMQz7EB++F0iuesPJtqWUWOqUEsqWeBp6wzLBaHnnnfj6YUnfQ7kna8pJM8iZ..2I0H54fOHxYH6CxNXeidG3xEhlvsKic+0tw+wewolDh..xIWI7a+CNwd1WbX1yS+mkMyAbXHEC6d8RuQutmc82PLXCazMdss4B8HCZ0xB5ARxJPxtBr6zGblXSHgdTK5dQUh7uguE4OruBtSlt8nkVf4QaFhMDj7iddsG.8nuGGx10mR1iKkFP9C6avR+Mp6EnZylB98+oXwyrI2H6dpOkzld5R3AeTW3ge7Xgcc5ee..1isMjQ+Nht84oJLf6Y2zHiAuyG4BC7ZnUmkaj3L9lQOu1CfTxoJdGJZF0TUDfJDiVdIEou1PPxOxcH6Gw2s5zuOy+GrGaa3E2rGzybh7rsWrpHE7fOpSrxelCcOV..l4bbfm4EciXhQ+DjRnG0h369YzsOOlv.umkQFx3EdEWH6d9SuJjBERR.cuOGGw28yx6PQ0vpPTGgI0kAz2DvMOrtq5O7vQVC3vvcRZ3EpvHoktDdtWJNDSXdJo1e7re8+VrXVy0XDhZmwdqwf+xp02kKNi9dDU+HoQClw8rmcSN0UQaq.cuOGA1j+wGElBqfFqzdUQ.LJFo21PHwLOERn6mS297BEC3piAqXUgWj4lFoL9G9mLVgn1YdKzNl7zB+i.JIohlEzgej0.JGJJF+fWy5d1Uc0wfksRy49AUvdrsgDynFdGFLiVpJBfAwHc2FBR9QZE9CLcoAB.T6OjFpXWWE1+6LT78u20he3qKDMWO66cR+K+qNQRIek+2kkkgjjB9O+uiERRrIzt6OsMrnEzD5adMftm3EP+KnArrE4Ee0Wvdx+2+mhENCS3eGiMKl+r..hK0Kfj6Y0p5uipQU2yTv5ehVvsbSW.Yl54QAYcdrv4z.9tuk8Wx8+7uzARTcKVnkm3S+huLaqZUQ.QnOiLBaHjR1mhoUeIP.fS7MEhFNc25v+MYzvo6FZ3LIiddMGDdRMxu6h3SPByegNvp+qsdE+YScF1Qe6Gaur5+1eoU7a+0MCEk1EtrgpOoB13y0F1zF8ge2ezYDqBC.Hqrjw7KwNdrG4JWMrezFBeMSwT6jdQGGMd1jfOuFSWCy58L+9UvhWXi3k2zOdsM1.vq9Rsgsu0FvyrIOXLiMxqtX7IHg4sP63A+aQ2JFFokgNAOR3EdzQBOtMtJw5bqAnnn.axAf8XaEwkRcH8B+AH6HxSlEqmltLgnDiM7qzV6uBBVaCB0tj8gBsVUDPDpLxHrgPRYcZlttZOVlWlPzkQ.Ybh8VH70JaKa9zl4k+is1uQsn6gs1T3UeIe3e6W0RGDh5T3DvF902WK30dE1F7TVH9d0pMDjiQAYd0GF.5WyV1QX8d1e6+aKWlPTGwaS.28B8hSeZ1hwoNCiemrrzY0KCUHJXXylMf.xvmWW37mnG3DeCaS1KGC6UVRgFbryUEADFwHOt0eaH3vcSHVOMGwqyuOITSEg+wUBzlcT6wtx81m1ZSAeyW2FV6i1BV4RZD2v0bALlQbkuz0dzCaXXCOxhYs1pB9U2Gauj366erEzRKQ982zu9KiBJ7xE1RIoXhJaH3NwFQ250Iz7e+PAq2yp67Ave9+SnuNYYYb9yA7HOvUJX2VaJXeecaXcOVqXUKyKtwqsQLtQ0XTE2QhLS2Al5smmg9cvBMUGaS12rJrXCuPsKkemIjiFKYl5uMDbmxEX55tvoREHPjU2q+Tohj64oPy0EO9u9uqDe9m4Gewd7CugYWNs8YMFy3Xa1iO7C7ipNAauf3pOoBdu2tMLg6HxypO5wDCJ+v+3.yEOmBhZaHjZdm.0WSRnk50uNTl06Yu5K6Kj48NNS8q9R9vhVRL3K9r.3y2sermO+h1nwq2N+2xXWh+ktvhf8X3eaDDeZrsn.mrJ19MHEpJJTDze828tYGS+NyS2+xbk.aKKbSmms8QFedcgx+vgnIWKesCgsaZu8VTW2Euss5mIwnAOjernzby1EJd7Q+NlojLPVCnbTwmNPf.5SOgw58rc9QrkmpnbEb0Ew9dhsQP+KxCF6HxfSe6APLw1JbDWyvSZmCIm0oX5u0W74ZqK2MKh1ph.BgXjQcZH3HtqX5ufRKMZ7mzH8s+r8uu8ue0Ud7A9N1dmHE0meTLbkkVDjjzm7crdZFcu2GEm5.5ygj.q2yN32G77DOmoN7u71OMr+c0hW8BF5kGxdkWLxuORJWUDPPdmQF4ogfcmW4JZELZyK6OdnV2KWXo6rAt3L4pgiVAahQY9+7JwF7.RD2zPUWCk134hKr+4Ik0o0MeMw58rJOdWMpnQwWtm1va7ZguxHdJDoGUEADDwnUsHiaeVl0UDvue1RrQSOWjbxr8uw5pScCxZnA1t9DS3he+ZYGyrp8UHBzVnieIIfLFP4vlJVAlPAq2ytP8W4+to9L0h.MTe.rnEzHLg9ZUSDMKkem4xDiF1PRACYfF3ogfDaYTEc58czNAaPgSWrIF4sI08q.udY65c5xFF2HSC8sP02ces0rKT8AyMrWiCm9PF8sBU+YeEv38rVh7Bt0Epjydl.XlSowHVcNED8iTUQ.cPLxLNMDBUe5zYrgHO.HZ6DUV2hlU6LRNbv1+F84SAKqDsuOhW2I5Apulvu0+lXF0F0lrj06Yc9UdQgAHhLaaKsha4lpGe7GJtKoudVUDPGDiLiSCAk1X7GnLNaLKDpAEMvXCm5NN08HqtXbSvrMexnGoEc6Xlm7aKDs0R3aGfL5aEP1Nau2mfAq2yhsCq4PWBQZi.A.NyQy.k+wCDybxMgiczHONfB4ZVpJB3+QLxrNMDBvPuCA.HKEdEW8veNr9tcRHA0IFkTRrc81ki9NL1uO63j6O7MJorC+HyqtbM+cv58L2zY+qWXQRBHkrqFu1t1MySpwKz6ph.9eVZey5zPvm2XgCWQtalkc1J72PjaS+LxvFd82xC15a5Ca8M7gO4i8i15v6aMbyZb7iE.4jaje2T8p.IbhJYOwmeuX68c4uY8o8EZnlTw4qpVjTlg9wwXwCegBVumkQVRnlZBDwYp6QOrgMuM2XaaoMrs2rMrqc1FZKLuL9ng18a0u5m0Ob6ikOm7w6+sFFrI2Fh0iWjTVmFIlQMWwiz1QjhQA+C+iNwMMhXvcN9FPyg4cwYkpJB.PJZsgfZn4FXSvydX9weGqJZHWuLJrHYbu+bm302d73HUk.V+y3FyY91Q5oG9aTe+9Y6kF0eF6Go1o28lsqWO6kppOP9vWyFiWtX8dFKB6..C45kPgEIgU9ybfMuU23v+fGr1M3DyddwfTSMZhzfSg44FSbLpamPPuQweLn45hGU+cEfS9sr8DHC8FhA+W+UwrbS8Zo76LR2ybidaHvJsTe36Ol1wchAuqe67imMta6xG.lPhRXxSyAd3GONbfi5AaaGtw+384.CXfW4.ku9qXKgdqSPc4lagQalzLi4BVPweL3DeSgL+R4UCrdOaHWmLSyTeqi+xymIjnDlzTsiG7QcEw6YZgUTpXcDregpSC0db1NIlWPowh6r3f+6OJTUjZQ5NGm4U9ZC0jLSCXhKkH+XENcBT7jCc0.xx1vPudY7qt+XwittqrJjsuE+HPfH+diF4MKiLyhseLmZp.iXTr8ijFOq9dHX587Ihy8C56twI.vMOgujo7zXt0HWYlSm.20jz98L0xPGTx3FFrA1pJZjScnbYdGm3+7u5BN6TARVgFbLXHoW1PfE76yN7VWjmo0UhMAWIc4FzryUEs3k3.ojJaw9assqLAd5Sqf874QVYzgCa3O7mYqiv+U2ervkqHGSMeAWnsVzeKuTygxEM2f9Zt4SeZEr6cE4Fe7Zt1XvvGQ3GjT18XGojJaB6A6dlZYUKRPORvCHiyTNaO5XlYJiUrJw9bySuvzONFN2OvlUSxb.kC4XB9RReUWsD9k+F1GL+7OSv80yCuZ1Vx6IMU639+2iE1rE5JDV4OyNJ8tYauwo1J0+JX..TTjPU6qHDPmVni1m.3QdP1xSOvZbhtEhsfp9O.I7+9Ww9dGTntmoFJHOw8HX+7U1czJi1d5m+Kh8R67kV0ph.zvIJazxEpNEzb9Ngy3CeK65vUKH+guWTyg6IF8D+JX2NPOxvFl7Tsi+k+UmH9DXSGcW6rM7seSvq.5UeIe399Uwxz4i1O+W3.CeDx3gWcqXmeneTasAPhIZCW+vjwcuLGXzigsToulsi5NIauy.sPK06Am4HYizKrxn5yoi6q1u7l7g+k+01P+5e3+2Xt4Ig2+Sci+3uuUr82zON24Bft2CILooDC9m+kNzk6YpA8vjp5kgYuRjPMGNajECscQRIKgew+hSb++q7qM2MhkxuyX5hQ1rYCUef7QNCY+gcINAt3FQdlW0QvAOt1mg6O7aC8r5ABXC+ut2lwqsMWLsOXOzqWFC8IitU3n5Cjmts8dDJN6QxDd514f6jz9FT1MdWa6R+uUT.9G+YdwqucOQLOkQFx3u8fQWNJb2yrRT2I6FRMuSDwIlA.Vxxcf07.sgpqVPMo1+CZspH.N7XZ.W7ksV6wM98Slm4oZMhsS+m7w9we6uXN+3+bUlFZnFCX8quBjhnYZCGM25UVUxG+g9wC72L9iEIVtmYUvlManjEx1Yema2R39Twi4pmXFUEAvIwH.fZNTOQ8m13dl9ucusg66Wv1fme2uoE7xaxXOtnar1DP0Qnao0S740ENUDLSanXzSM3mFu2++ZyXKugwIbql6YVE15a1F9jOlse6M2EZG8p.woME5LQSUQ.bTLBPBmXu8wPDj1+21Fl9jZFMx7SoXCKoLuXcOlwLP6BUmBN9WzWX1o6yUY2QCprEBBmUa76Gnz41jgHHo96Yzm1y0+1eCauKH61sgeyu0bWYMyppH.tJFcwU+4G9p9hZJOSDvu9n3+xaxGlvX8hScJ08r098aC+heVKXYK1KpgwSvhHQqMCT02kGNw2za.EyOUaylMT09J.9aU+VAllaFXNSqI7e7+gsCe.VPq2yrJ7Iererssvl.+cM4XvfFLWG1FTh1ph.3rXDvEGvblJxAkuyAhyUYZZ98br6OsML8haBKdgMi5YaOjOnrwmsMbcCrQ7a+MsfieLsIJc1ynfm3QBfJ9jqE0chq7DLwLweqNvIYbKnkUCHqn.7m92aE2301Hdp04CM1f1xS508LJRmy0+a+5lge+QVLVRxFt+eu4TcjQuT9cFa650mfXMcjje7a9quGF9HjQ+tJYjW9RH8zkfK2.wFqMzZqJnwF.p5DAP4GN.97OK.dqs5GG9PFwYFlBFv.kwnFsLF3fjPuJTFYkMfm3rAWtsg1ZCng5UPs0BbnC5G6+aCfc7t9wt1Ya3+5+uAKjc+a3PqagutcCL7QDCtwaRB8q+RH2KcOS4xtmcxSnfxKO.9rc6W2um8n+mCA8u253IerAhZ10Irx8UTmwzWZ+HR.Y7VaqM7VaKxc8qweixF12dCf8sW0MnYnCJEKqPTvnol.d6s2Fd6f+duMbF6HRiLBQpgeJIDAH.OlVmQqyNKJHIEPbsgPHPQEamkhVd2tcErzEPm7sdrWbYUQ3DinNS3VxTnsgPvniM3X3PzDh..l5DyAY0C8aGPPT3mZUEAHXhQTupHGN.Vx7Kj2ggpvWah0qLTM3INIT1rLud2JZgBUEYlKkemQXDinvMpHwblTtHsTDyMDqPwHmLcqJpzY1KDuGqmi1EwbcmQuqJBPfDiXEQ8FUxIJi4OM84Tb0rfxS.zizbfocGZqCy4ATnpedVUDffHFQ4AEsyhmSAvsKwawI0CDwI.Vx7KzPNB16hHiQTUDffHFwJh3fB.fbxzIJd74v6vPUP4I.5SAF2QvtQPWUEwFbWLhxCJZmkWRQPVVbMvXzfHNAv8VlXsuVGNrB+9tiXTUEAH.hQrhHNn..Xf8KALpgwWKenVn7.jgecofq8pCw1IIggBUEYjBQ.bVLhBkuFIV0h6CuCACCQKuKIE.2aYZ+HA2rgxh97.tIFYEtQM1QjF5eQIw6vPUP4I.Jd7YibyNddGF5NcUUzEQ3eLMQbPA.8rg..sm.vkSaXwyw3OB10KnbtlWvEwHqvMJqpMD.DyI.l6TxCojj9e7Nwa5ppneDgtxHQbPA.8rg..sm.H0jsaZGA65AT3QgEgkxuyX5hQTdPQ6XUsg.fXNAv8LuBfqXEu35mBXVUEAHvUFIhCJ.nmMD.n8D.42SW3NuUy6HXOZoqphzNlpXDEtQEIrx1PPDy6qnztZvQdgYVUDfIJFYEtQQMaH.P6I.FxUmHF90Ybm9t7htpJJ3HbSwKhCJZGJYCAq.c0fi7CytpH.SRLxJbihh1PfxUEcait6n2EPqFJkEnPUQ7PHBPvpLRDGT.POaH.P6I.bXGXYKfN6XlTNWKRX3hQVgaTVUaH.HlS.LyhyAo2M27NLzc5ppnvivTYjHNn.fd1P.f1S.jX7xXgyfN6XlT9QgEMLTwHqvMJqpMD.Dy79hlcuPbtry6vfInhnOEpJBPfpLRDgZ1P.fNCPBFYmgSL4IRqcLSVfBOdlHfgIFYEpJxJaCAQLuurETHhQlFyORYQ+fAuqJBvfDirB2nnlMD.n8D.CnuIfQObZsiYxBcUUD6v0ogDwAEsSWM3n4xJKsHxjusBS11QDgph.L.wHqvMpqaPIggMDZYCAJWUznuwtgA1uT3cXn6zUUQpCtcPeIhCJ.9oWCN1u9KgQOVYLjqSFETfDxHaaviGfXi0FZoYETeC.m7DJnhxCfubO9w6uC+Xe6MftE6xxJX4kPmcLSJK5GLDkph.zYwHqPUQiaTYfhxOwHdc8ab6R0e1G+K5CZ7rIGz+LOc6rnmC9Pp9yb+u0vX9Zae.hSm.yuD63tWlCz69D5hicGmM3NNft2cfq4ZkwTmwEWx8ier.3wWSq3IdTenwFTcHiZapyMP59X5uWf..JArg.9kQaM6.s1jK387dP8mIYzVyZq8KT68w5ZQ6VTIE20q4+tpAprT9cFt7NiD0YMLZaH3LgF0zeV3PsS.LgaWF69qci+i+hyvJDENxIWI7a+CNwd1WbX1yy7JtVRBPNFEXO11fqDaBIlwYQO52wPQi7qPNW62AmIXNC16BiAcSLxJT9pQaCAmID5xHzpXDqDSLR32+mhEOylbir6o9bOH8zkvC9ntvC+3wB61UzkOSsRbodAj6P+VjduOB.zuGijZP0ph.zIwHqvimYF1PvHpLhUdvG0IV4Oygg7YOy43.OyK5FwDCeEjjj.RM2SgddseOfse5JHQUL0GSSjqJZwyo.C2FBNb5CRwz5U7eWNlVg8Xayv9du+euKLq4ZLBQsyXu0XveY0tLzuCVwSp0gLupCy6vvzgxUEAnChQVgphxNCmXRSnmlx2kyDZho+a5EiZzNv+v+jwJD0Nyag1wjmlXLgShYTK7zsZ4cXXZPwkxuyXZUFIxUEYl1PHXu2nXCy6RJZPRB3+7+NVHIwVyDt6OsMrnEzD5adMftm3EP+KnArrE4Ee0Wv9Oz+8+oXgSAwWw8neGAPh9CR0SD0ph.hxk12JTUjQYCA+sYCxA4cn3JHUAEr+ag6yfUlwriE8serMIve6uzJ9s+5lghR6BW1P0mTAa74ZCaZi9vu6O5DqXUQtBqrxRFyuD63wdDeA8OeXCIE.D7+rNyO11BAfTLsgX83EwmdsHorNEjY3Wt1c5CIkYM37UF82eSL1yG1+7tZvwnGSob.QtpHixFBMWevOsYC1KpNTu75P8YvJK5dX6cf8pujO7u8qZoCBQWNABXC+56qE7ZuBahHkEhuWIo.XkZpAGkPf1b.umOQb5ClONxtFD74ks+skXFmQCeepCQ922cDQtpHfnPLxJrT9FoMD7VWv2YHc3pEHEyONn1VLsAGtZQUeFrPVYECF1vib4Cs1pB9U2Wv+96L22+XKnkVhbkZ8q+xnfBuRgsaeLYhdkaBL8cEN740ENw2vlnl6jZ.w3zaT+cJpXUpJB3mv6mQFsMD7VWnqpI13+wJgb5IzKoe39LhDiYbrMIvG9A9QUmfsGEr5Spf26sYaU+F8XtbgPmwdwybN8Bu0k.ZrVOLcswkrw0Ljh7jscDQupH.MJFYEpJZpSLajcFr8iYsf2yG5pZb0gGKyUX5uHsVYjrrLt1gvVt+s2h5ZofssU1lIdvC4x+o0bmRdH0j02k9ugZBt0Z5LwZv8vEuf5KkemQ0u.aqvKs1sKIT1rM180Z+sFK70RLAs+g536HJTcksuVrC+sDqp+daeBf91e1lmY+6Wck4efuislIrn97ihgImnrgriYx56TKbUexJTvSZTlZp0qw8XZhbUQkLi7Qhwq9A5pkPUcTGEihM9fuRZQyinA.zybX6kxWQ4pa05NZErIFkYV+3+66dtEB2N0eOr0ZSr0CAwXfMTJuvpUUzZ1vgUmXjUnpnt2M6XlEmmo7c0THDTr6rEXStM.I+vg6lC50nkGQqiS.jbxrIFUWcpSLpgFX65SLgK98ma1tPwi2X1wL86mMANoXrdhQVIJ+n0gs9dUYL6mQhbUQKcAEAG1Mm2aeygPPQRBvY7MBEEIHEhPw64it2mkSWrIF4sIE.vdqM30KahQs+8uhRJDRg5ejQIJsw1mqbLVmUbBv5UUze+INDBDPhcwHqPUQEkebX72bll12m2K3AABffJ3ztXTvHP.02iQcdBf.L5STEU1SkNbvlvkOeJXvCHQLhq231WqCUeQEjqzvhAyFqzR4C.7oeYM3y95yA.CXo8E4phL88Y4.xn0FB9JH4LgFgy3C9KVs0FcBE+wDUS.z.iuyT2wot7gKF2gUZrAX36XlRRLJxDfF6s15ITnpHEEE7fq6fW5+OShQVgkxeXCIELzqIMS+6MTu6GmIz.bEhURSsuunfk2Y8c6jPBpafZRIw106uMYz2B09JPwBRL93W9CHt+tTMX0pJZKu6IvgO5Ot.NQ7wzrBOdljT.rpx3y9rr2K3AIiSeE+2c3tEfP7XFduPbQcd+3GK.xI2HOWSuJPBmnR1+Qd98hshosaK5VMPVP1wUtcrDL72bzuqEjXrmWnmrsiPgphZt0.XMa3x2lWzsGSSjuQcGiMKjWOidaHnEB0KhVRBPRN3UunlJiBUd+62Oauzn9yX+H0N8t2Ld8sZb6XlsSrdXylGspChQ7FqVUQa7Uq.0T6k60wv9KKqPUQNi8hmLr7hVZzE76i8A7AZyFF5X+vn968q+J19w6sNA0sfp2Bi1LIZM4KK3N45X55ZognOVD4Ia6HTnpnyUWK3odwicE+20kJiD4aTFgMDTC1rYCMeA1WlduWHNnGSBt8s3GABD42azHuYYjYVr8dfRMUfQLJ1tW23Yi7IrRzfTL9PR8fMG42z4BdklTYxVq1R4u1mubzj2qrx8PJFQkaTgCixFBpklpicwnGac5yVdwoOsB1ymG4GUygCa3O7mYqaz+U2ervkqHO+UyWvEZqEibGVK.x3pJGRLbH.3uUYzz43yin2EWIGupFvqr0JC5eVTWYjHWUjQYCA0R3LMam4y2s90svO7pY6E7NooZG2++drvlsPO3dk+L6nz6ls28RsU1cltNVQQQAPxOr6xKRnG0f7t9uEIjd32ryZmyd7LPv9YNUlr0pUUzCs9CA+9Cdk3AcjpUXo7MRaHnV7dA1emEe9t0uWT4q9R9v88qhkoyGse9uvAF9HjwCu5VwN+P+n1ZCfDSzFt9gIi6dYNthsDjPgulsi5No9bzfqkCJyKKVZIFb1ikgtDKW4AOo54m5Fl8q+1yhOXWgtx+q3WXTYFiHgQZCA0R.eNPqME6EWN+vvIOI66sPL88FvF9ecuMiWaatXZevdnWuLF5SFcuespOPd.ADi7dMGtm.AoGinxuwsRUEonnfUu1CF1qQy+pQjqJxnsgfVfEW3qmUE0NexG6G+s+BaOtVzx4pLMzPMoZJeWQhZ+gzQcUckOtnUSHhJ7teb036NT3O3ItLwHpbiJRXz1PPKzDCu2HiPLB.328aZAu7lXa+qVqzXsIfp2O+Wr..fKb5jP0GPLhEiFJTUju1TvCu9vWUDfFOcPD4phF2HSyvsgfVvKCKuud9xqubrgkTlWT24UX9kP+uWeqH...B.IQTPToFtP0ofSruBAu2EiCD.n1ikAN8gyA1BxNQ.Ulr0pUUzKukigpNcjqN+RhQT4FU3vdLJXYkHdUEA.zxEhC98aCxgnqq86WAeoJNexTK98aC+heVKXWehe76+iwhzRO5ENZr9.3jGLG3qV9tPAA7aC0eljvYpHazZCwohMDEZCEpJpglZEq84JmoqU0UFIxUEM86LGzizLdaHnMjPK0GGbmTvet4Cre+nQi4rb7xXiOaaXKuQaXQ2iCT1camI+q0YN6YTv5d7VQSmpGX5Sz7DhBD.vuuXfeexvWyNQy04AdOe7no57.kHrQqQkIasZUEs9MdDbgFXyZR110qOAEqvR4mfGI7BO5HgG2zwGR7OuqfALPYLpQKiANHIzqBkQVYC3INavkaans1.ZndETas.G5f9w9+1.XGuqerqc1FRMIG34djQAmNDiUNKRv+bMaXkVAspqoIL6k8QvWarUqJ+6HPchRmUurjBQFK1v91a.ru8x3NwVG96sj4WXWBQ5LVIgH.fGd8GjYgH..IpbiJbjY5NvTu873cXXHHh48ByyMl3XxJxWXW7SVNvgOOdqOrFU82gFSsEAV5BKB1igNu1RwnpHsyxWnIuiYFEPkIasZUEEoFbLXvjXDuuQEN5eQdvXGg9zx+hFhXdenCJYLrgnO18vng5h9TkO9yNE9x8w116RGg7UFcuk0axLKM.sGfHIE.qZQ7YGyzHg2h9VophBDH.df0cHM82MhhQ79FU3XjWepXPWkXX+.8FQLuOgaISTPdF69TjdAUD8sZKk+q+VUhiUIa6.mcFxVYjrrBVg.Z6ivAUd+EACGN.Vx7Kj2ggtiHlqCFTnpnlZtM7nOCaM3XvHrhQh7MphGe1HmLitC5PyDpLScnX1EmCRKE9siYpFnRt1pUUzy9xGA0ddsaooPJFIxBQtcIgEOG9suVajHh48jSTFye58h2ggtiHlqCFTnpnydNu3Yd4iFUeFj7wzVvzxEImHaaUph.TYl5PQYyp.DmK67NLXBp7nvVsphdzmtbzb32tthHAULh22nBGokhcLyIY8lkFPLy64joSL4IjCuCiexBEpJ5n+vEva7NmHp+bHWkQTxFB.zupnktvhfrLMZcBqVUQTPHB.3uu1Cg.5vt64U7Iv6aTgCqrMDDw79.6WB3lGl9t45aTPcQepxd1aMXW6oVc4yhNkX.fUTp0rAGEQgH.fUsH5X6CVg24ZqTUQJJJ3u+DZqAGCFWlXDuuQENF5fRF2vfSi2gwOY3VtozP+6cJ7NLXhtpJhOr82uJbniznt84cIwHQVHhh1PfxUEY2tBV9BoU9lE3ct1JUUTq9BfG4ozuph.HxioQIaH.P+YpmxD5IxpGQ+4SuY.Ux0Vskxeia9n3TmQeOjGj.3+LFgCqpMD.Dy7tm3jvhls0q0IDwbcvfBUEUW8sf0+BGQ2+bE9JilyjxkL1P.fNyTGJJYF4i38PiFJkJOJrUqpn09bkil7p1cGzHiDuuQENRNQYLuoYMO+qDw7dORyAl9clGuCiexBEpJpxS1.dosTog7YKzUFs34PGaH.P+phVx7KDNrKz+j3RzUUQ7gGZ8GB98aLs6gv9KubxzIJd7VSaHv6AHAi9TPbX72bl7NLXBpK5GLnPUQ66.0hc7Imwv97EVwnkWBcrg..cloNTPscLSVf24ZqzR4qnnf+9Z02kxuyHjhQCreIfQMrdv6v3mLL7qKEbsWc23cXvDVwphn.6XmUi8cfKXneGBoXTWM3n4gjT.buDaGyjE3ct1JUUTa9CfG9oNrg+8HbhQicDzwFB.zel565VyB4lc77NLXBpmqoJu5V+AT4Ia1v+dDJwH61UvRW.spJhU38L0ACmwBb2yy50Po7NWakpJpQu9vi+rZeesVMHThQSch4PFaH.P+Ypm2TyGojjSdGFLAUdTXq1R4+juPEnt5Mm+MILhQdhSBkMqtZvQyhTS1NlyTnQ9l5h9ACJTUzoOSSXia93l12mvHFM2ImGjkDuAsgBpO.ojYjObEKcx2r.uE8sZUE8fq6fnU80KrgkXb6h+5QoljCLpgkNb6NFdGJ5Nw6Q75f7r5QrXnWCMVj.0H5y6eKWeCVm2UzW7M0fO4KNiolSiwHL7lZoIuMi7ygFqnCf5d+EhP9sybni3E4jEcx2r.uy0Vspht1qNMLtQkId4sD8az9rB+KKB.e7qNNdGB+jhLS2AuCAlf5OJbvfBUEA.b7pZ.ad6FigXCEBgXDkfJqpS3XYkXsZxQdmqsRKke67fq8fFlgXCEbWLhRUEYElot+E4Ai4lDeq1XED8oJe49NK9vceVS+6kqhQTRHRMHxCPrhFhkmX0pJRQQAqdsGjKe2buxHpfUnpnQMrtgAcUox6vHhzUUQ7i24iNINvgafKe2bSLpqphLWjkUvxKQ7sZCkD8sZUE4qME7HOowtMgDN5pxHFfRCPBESdBYibxzCuCCcCdK5a0VJe.fW5MOJp5zsxsuetHFYOFEd70Z3v6AHgB2tjvhmSA7NLhHVAQ+NCUpJpglZEq64qfqw.WDilwckKO9Z0DVg2ewBlVtHw3owI9AKv6bsUrpn087UfKz.eaPWSWLJAORnjY1kAMMKRKE6XVSR7y2VgbcmgJUEUcMMgM85lmgXCEltXTYyt.3wMM5.XVg2yTGNVx7KDw5PbiO0Buy0Vwphd30eP3qM92tGlpXTlo6.SYhz3QzrByTWXdtwDGSV7NLhHVgGEtyPkphNvgOOdqOrFdGF.vjEiVVI8F1ig+Jv5Ih7.jUTZWM3ndhUao7A.2ZvwfgoIFQEaH.XMpJ5FFbx3FFbZ7NLhHVwphnBeztqFe49pi2gwkvzDirh1PPTGfHIE.qrztZvQ8DqVUQABD.O35M9S7C0foHFQEaH.XMlodB2Rlnf7Rj2ggtgHmqoJad6UhiUoWdGFWFFtXDUrgfUAGNt3JnI5zUUQ7ilZtM7XOiXUUDfIHFQIaHXEpJZNSJWjVJt3cXnav6bsUbo7e5W7H3b0Id+6xPEinhMD.n0L0ghjSTFyeZ8h2gQDwJjq6LTopnydNu34d0ix6vHnXnhQKb54Yorg..+moNbr34T.b6x5bnFv6bsUrpn0rgCilag2QQvwvDiRKE6XlEmmQ8wqqXEloNmLchhGeN7NLhHVgGEtyPkphp3XW.u46VEuCiPhgIFszEVjkxFB.h8.jkWRQPV1Z05D7DqXUQOv5ODBDPb20fLjHqv7biIL5LMhOZcGqPUQWS+S.iZXheCk1UUQ7iO6qpA6ZO0x6vHrXHhQVQaHHxCPV4h5CuCgHBkD8sZKkuhhBdf0wucvQVQ2EinhMD.rFyTO1QjF5eQIw6vP2Pjy0TkstipvgNRi7NLhH5pXDUrgfUA61UvRWf3mu6ppH9Qq9BfGcCheUQ.5rXzsOF5XCAqPUQSch4fr5Qb7NLzM3ct1J9Rq23lOJN0Y7w6vfIzMwHGN.t64I91P.fVyTGJ7DmDJaVcsCNxCnRUQ0UeKX8uvQ3cXvL5lXzbmbdVJaH.v+YpCGkNydg38XcZnTdmqshUEs1mqbzjW9tuVqFzEwnjSTFyaph+rz.ViYp6QZNvztCweGyzJ7nvcFpTUTkmrA7RaoRdGFpBcQLxpYCA.wd.xxVXgvgcws40.nknuUrpnGZ8GB98Sq1qIp+EMUrg..sFfDJ5SAwgacjzngRYAQVzuyPkph169qE63SNCuCCUSTKFYEsgfHO.gB6XlTRz2psT9ToAGCFQkXDUrg.f038WL7qKEbsWc23cXnaHx4ZpxN1Y0XeG3B7NLzDQkXDErg..sloNTHIE.2aY8l2gQDgR4ZqVUQs4O.d3mR71AGYA2tjztXjUyFB.h8L0EO9rQtYGOuCCcCQNWSUdksbbT4Ial2gglnjYju1DinhMD.n0L0gBWNsQhcLSJ8nvVsphZzqO7DOWE7NLzDcuaWbuOSShQVMaH.HFCPBEyep4gTRxIuCCKCVwkx+IegJPc0Sy+cszETDbXWCOlFUrg.f0npnTS1Nl0jE+7MkpJhUnRUQUWSSXia937NLzDEkebX727EaUEUKFY0rg.fXO.4dlWAvUrha7APKQeqXUQqYCGFsRCuvdErxRK5RsphpDixLcZXCA.qwL042SW3Nu0r4cXnaHx45NCUpJ5fkedrscbJdGFZhgMjTvPulebuOSUhQKYAhuMDrRzUCNpuXEqJZ0q8f7NDzDRRAvJ6zg6JyJK8sPOjwFBVgphttAkDF1PRm2ggtgHmq6LTopnc94mF64api2ggl3NFaVnW4lvk8eiYwHJLKM.sloNTzUCNp+X0VJeEEE7fqilUE4L1K9tP6LLIFMhglBF7.RU2CJdhHOS8scyYfhxmF6XlrfHmqoJu9aWINxO3k2gglXtSIOjZxW4deVDEijjBfUTp3OKM.sloNT3vNvRlu3uiYRoGE1pUUj2V7iG8oKm2gglH4DkwblRvaUkHJFY0rg.fXL.ITLyhyAo2M27NL5BAlm8kOBN64n4Z4e2ysP31Yv26yBqXDUrg.f0npnDiWFKbF8h2gQDoqph3G0d9lwS+RzYestija1tPwiOzspRXEirh1PPDFfDJV7bJ.w4xNuCivBkD8shKk+i+rkilag2Qg1XEkTHjjBsjSH+SRMY6X1SQ7mkFfVyTGJxNCmXRSnm7NLzMD4bcmgJUEcrJqGad6zZestcF7.RDi35C+deVHEitm4U.b5nqFbzrXYKnPDirXmu6ppH9xpW6AQf.h8uQBErzpJA8eYTxFBVgphFPeS.id3zXGyjED4bcmgJUE8EeyYvN+7Z4cXnIF2HSC8svHu2mETwntZvQykUUVQBe9lR4ZqVUQJJJj01G1iQAKqD1ZMnqPLxpYCA.wdl5QeicCCnuov6vP2Pjy0cFpTUz1e+pv2Wdi7NLzDS+NyA8HM1ZUkKSLhJ1P.fVyTGJjkUvxKQ72wLoziBa0VJ+V8E.qYCzbesNAORnzYw9hfcYhQVMaH.HFCPBESchYiryvCuCitPf4EeiigpqoUdGFZhRmUufG2NX95ujXDUrg.f0npH2tjPYyV7anztpJheTeCsf0sQZtuVmY5NvTu87T0emKIFYEsgfHL.ITTxLxGIFuXuiYZED8oLq84OBZnw.7NLzDKcgEA6wntEkQBfN1P.fVyTGJZ+zPvpfHjqsZUEchpaDuzVn49Zc+KxCF6HxP0+8j.ngMDrRz9ogfHCkpJxpsT9..OzSdH3ymX2tGgBs1ZPRTxFBVgph53ogfU.QNW2YnRUQe2AqEu2GWCuCCMwHu9TwftJss2mIs7RJR3sg..sloNbrpE0UCNpmXEqJ5u+DGh2gflPVVAqHJZMHoadXcWGCG9iHOS8vFRJXHCLsHegDAQNW2YnRUQevtpF6c+Wf2ggln3wmMxISs2pJRh9rz.zZl5PgjT.rpx5pAG0SrZUE42uBdn0Syphb6RJp26yD+mOSEHBCPBE2wXyB40yDh7ExQrBh9ACpTUzl29wwwqpYdGFZhELsbQxIFcsphvKFYEFfDpSCAphHH5a0VJ+F85CO9yRy805zRwNl4jh9VCR3EiXEQX.RnHTmFBhDVAQeJyF1TE3b0QyG6bIyuPcYuOSnEinz6uHTjRRwDxSCAJhHjqsZUEUSsdwysYZ1fiElmaLwwjkt7YIrhQVkYpW7bJHjmFBhBVkbMUYMa3vnUZ5EVr7EpesphvJFwJhvL0ghHcZHPMDgbsUqpnxOZcXquWU7NLzDCcPIqq68YBoXjUYl5UVZQg8zPPDfROJrUao7AtXCNRw80ZIo.XUKReaUE5kE5.hv.jPwfGPh3lFp0pgRoBTopnO8KqAe1WeNdGFZhIbKYhBxSe26yDNwHqRUQTXGyrqph3GJJJ3AWGM2Wqc3vX16yDNwHVQDFfDJX8zPfmXUD86LTopns7tm.G9nMw6vPSL6hyAokh92pJBkXDkloNTnlSCAJfHjqsZUE0bqzcesN4Dkw7mtwr2mIThQVATyog.unqph3Ka7Uq.0TqOdGFZhxlkws2mILhQVgphT6ogfniHjqsZKk+4pqE7Tu3w3cXnIxISmXxSHGC6yWHDirJyTW1rKPUmFB7.qRtlp73Oa4nIuzbesd4kTDjkMtc4CgPLhUDgYpCEYltCLkIlKuCCcCQHWa0pJ53U0.171qj2gglXf8KALxavXaUEtKFYUlodYkzaUeZHX1XEdTXJyCt1CB+9E6eiDJLicnTtKFwJh7.j9WjGLlapG7NLrTX0pJ5q+1yhOb2mk2ggl3VtozP+6sweDryUwHqRUQZ8zPvLgRUEY0VJeEEEr50RyFbztcEr7EZN6PojnxHQX.RnHZNMDLKrJh9cFpTUz67QmDe2gZf2gglXJSnmHqdDmo7cwMwHJMScnHZOMDDMDgbsUqpHesofG4Io49Zsm3jvhls40pJjnxHQkIOgn6zPvLnqph3KuzadTT0oo4lUToyrWHdOl2QvNWDirBUE41kDJaVcsuVqmX0pJpglZEq64qf2gglnGo4.S6NL2VUwzEirJyTqGmFBFMVkbcmgJUEstmuBbgFnYCNtj4WnoeDrKrOllHLScnPuNMDDEDgbsUao7qtllvldcZtuV2mB3yQvtoJFYUloVuNMDLRrBOJLk4gW+Agu1D618HTvqVUQHGQIxCPzySCAiBpI5a0pJ5.G973s9vZ3cXnIF90kBt1qtab461zDin1.jPwJJU7avQVQjE8oLTsAGkjBv0cnTgqxHQd.xPGTx3FFbZ7NLBKTSz2pUUzGs6pwWtu53cXnIJd7YibyNdt88aJhQVg2egQbZHvSDgbsUao7CDH.dv0SycvQmwdwy3OdhvUYjnhQbZHn2PsphXEpTUzl2dk3XU5k2gglXdSMejRRN4ZLX3hQVgphLpSCAdgHjqsZUE0TysgG6YnYUQolrcg3HX2PEirJyTOmIkqgbZHnmXED8CFTopnm8kOBNWczTf8dlWAvUr7+2EBwioIxCPRNQYL+oYcZvQQ.qVUQm8bdwy7xGk2gglH+bbg67VEiifcCSLxpTUzhmSAvsqX3cXDV5ppH9xi9zkilag2Qg1XEkHNspB2qLRjGfjSlNQwi23NMDzCnlnuUao7q3XW.uw6bBdGFZhgb0Ihgecoy6v3RXHhQTa.RnvnOMDLSDYQeJyCr9Cg.A39b5ZBQ6HXmqYQQd.x.6WBXTCSr2WqolnuUqpnO6qpA6ZO0x6vPSbait6n2EHVGA65tXjU48WrpE2GdGB5FhdtlhnnnfGXczbGbzgcwrUUzUwHpMScnXriHMz+hDqYM5LTKWa0pJZ6ueU3PGoQdGFZhYVrXdDrykGSSjmo1tcErzEzksOzSrZKkeq9BfG4onYUQIFuLV3LDyVUQ2Din1L0ghoNwbLsSCAshU4Qg6LTopnMt4ihScFe7NLzDKZ18Bw4xNuCifhoWYjHO.wSbRnrYw+1h2JgUqpn5puEr9W3H7NLzDYmgSL4IJtsphtHFYUpJxrOMDzBcUUDeYsOW4nIuzbesdYKnPDir31FBlZjIxCP3wogfZgZh9Vsphp7jMfWZKUx6vPSLf9l.F8vE6VUIpEirJyTyiSCAiBQOW2YnRUQOz5OD76mlMA6JKsHgw1GgBqwnunDdcZHnFrpUEQEgn8t+ZwN9jyv6vPSL5araXf8KEdGFQjnRLxpTUDuNMDLBD8bMEgxM3nrrBVdIznUUzrXD0loNTvySCAVgZ4ZqVUQ6XmUi8cfKv6vPSL0IlMxNCw9HXucL7GSSjmol2mFB5Mhbtlpzl+.3geJZtCN51kDJa1z4HXWShQTal5PAuOMDXAp8nvVsphdksbbT4Ial2gglnjYjORLdwtUU5HFZkQhx.jfgKm139ogfUCq1R42nWe3IdtJ3cXnI5d2riYVbd7NLTEpVLxpTUzbmRdb+zPHRPsphXEpTUzS9BUf5pmlBr2y7KhbsphgEsh7.DQ4zPHbPMQeqVUQm9LMgMt4iy6vPSTT9wgILZwtUU5LGqx5UmXjUYlZQ4zPPOPzy0cFpTUzC+TGFsRSuvRhFbryr50dve50zi42Sw4zPHTzUUQ7kCcj5va8Amj2gglXXCIELzqQrOB16Lew2bFryOuV1EirJUE0UCNxOnRUQqdsGjj6q0RRAvJIRCN1NJJJX0q8f.fw2YD0loNTbcCJILrgHNmFBACpkqsZKk+N+7SiO+qOOuCCMwsOlLQuxMAdGFphs+9Uguu7KtiYpqx+h7L0c0ficQjPQQAO35NHuCCMgyXEy805vQq9Bf0rgergRinXD0loNTLtQkAJJ+D4cXDVn1iBa0pJ50e6JwQ9Au7NLzDydR4gTSVrOB16Lu3abLTcMsdo++5VkQhx.jfgC6WbikRjwpH5SU71he7nOc47NLzDImnLl2zD6VUoyTeCsf0swKugRCqXjUY.xLKNGjd2DuSCAsfnH5a0pJ5Ye4ifydNZtV928bKDtcJ1GA6cl097GAMz3kuiYpKUFIJCPBFh7ogP6PMQeq1R4W64aFOyKeTdGFZhby1EJd7hcqpzYNQ0MhWZKWYCkFRwHp89KBEKdNEHrmFBpEQOW2YnRUQO9yVN71rBuCCMwJJoPHIQq1P3QdpCAe9tx1qgV+qPkjcFNwjlPO4cXDV5ppH9xwprdr4sSy805AOfDwHtdwdesty7cG573c9nZB5eVPEirJUEI5mFBpAQOW2YnRUQTsAGA.IaUkG3I99P9mcE2En1L0gBJbZHPMQeqVUQsaCAJx3FYZnuEJ1GA6clOXWUiu56B8NlolmRPTFfDJnnYAsJPgph5nMDnF1iQAKqDZUUje+J3gVe32GwuLwHqRUQT3zPvpVUDEDh.tbaHPMl9clC5QZzpUU171ONNdUgeGyTSUFIJCPBFT3zPvpH5SU5rMDnDI3QBkNKwtUU5LM4sM73OajanzKIFYUFfPoSCgHgnH5a0pJpy1PfRT5r5E731AuCCUwFdwJv4pKx+FR0UFIJCPBFT3zPvpH5SUBlMDnBYltCL0aOOdGFphZp0Kd1W8XLcsR.z68WDJn1ogP3PTx0VsphBlMDnBKcgEA6wPqEkYMa3vnUFKBUxpLSMENMDnVt1psT9gxFBTf9Vnm+es24+OUUYbb726bC7Fpg2qcWpfHLgYVVLaQ0JaNyliVlFkyzD0j0rgM+qgkYyovcN0fxnHKc3zlZtQ5bNbY0DAtR5cW6Jf3tdAA7b6Greoa7Pmu8bd974YmW+LbOe3gc9bdetOed+7FqdEyW0kgsn2DifS7SIs7OukeMMp7jZQ7IakeogfHn9Zc9vEUQhrg.GfimPoMcfdr0.kpE28VUEyDqYkzNMD31qBqaphlNaHPcVQMQwxW1bUcYXK9kKmFWr6gs0uikZFQkaPDQv.NpN3hpnl1uXaHPYBEJG9zFVhpKCagSOwLYuxHNjFBAphTKmsqT3J+tXaHPYV2ZJEks.dMpJG+z2BWOQVa+68+1LhJ2fLUXXXhcuifAbTUvAUQVwFBTkhdbC1EA6iMtyGnzosYDkaDA.71qtDT9B4UZHHBprVqaakuUrg.UYqu+hPjh40npz120GROjyNwLY6qoEdFOJYXoL5rpHNv8GcBKYCAJRrnEfMtddY6igG4A3fG0ZC33TgvlQT4I0h3CqieogfHnxZstoJ5PGseKYCAJxNquRDtPdoUn4V6EYG04CTJu9q8eHRwgvlqi1ogPfpH0hcrg.0nxxKBu0aThpKCaw.Iyfu8Dt6DybJaFQkmTKBNlFBhfJq05lpH6XCApQiaieipxmGuG7vG5tZlcJi3PZHDrU9pE6ZCAJQMUGg7Qvd9z8UGDmsq635Om+SyHpbChH3XZHnKvEUQ10FBTACCSr6Fn8npjOd4IlIq9OFGRCg.UQpEmXCApPsqZAXwkS6HXOeN84SgeqmLdxm0+pYDUtAQDTOMDz4uzZNnJxo1PfBTXgOZGz3DSLYNr23d258iAP+lP.7LMDDAUVu0MUQN0FBTfMstxPrn7ZTUZ+32.I+KuaWBLnxMFSGbHMDBTEoVbiMDTMQJNDpeC7Z.Gyjcbz7W5sCTJK9Ni3XZHHBpz7W21Je2XCAUyN9.9EA6waqebuLd6IlI4aFwgzPPmUEwAbqMDTIkN+v3cqsLUWF1hToyhu56890ax2LhiogfHBTEIG1+QbmMDTIMt8pPnP7Z.G2a7qgIlz6qYR2LhCog.21JeciARlAczo6rgfp34W5SfU9JOkpKCaweb86hSdN4bhYR5lQTOMD33qmoaph1SyWy01PPUvwSnTYFI3jsYzyTE+RCAQPEUQ51V428UGDm6BCp5xvQrpWKFV1SS6HXOeN+EuMt7uNhz97IayHpmFBbTUjUgCph7RaH32TPA4PiaiW19vzzDeVKx8DyjjMid8WZtn5mkWogfHBTEIG7RaH32TWsKDkLuYp5xvVbrSdSbiaNpTuFjqYTnP4vtBr8gxfCph7ZaH3mLqhLPCah1ipR9jcrIw9Nr7OwLIWyHNlFBhHPUjb3a9wDdpMD7S19Fq.ydV75bs9Hs2OF5tSJ8qCoZFwgzPPm2JeNnJJS1wQKs1mpKCGw7hUH1vZKW0kgsXvgGEGt8D9x0hTMi3XZHPczssxukV6yysgfewNquR1EA666P8hwdf+bsHyJCGRCAcVUDGHU5r3qO1.ptLbDKYwzOB1ymD+48vObpa4aWOxzLh5og.G+Rq0MUQxxFB9ATeTUlJZpY+8DyjD28ywzPPDAphjCxzFBxlW8EihW34dRUWF1hKckznqKMjudMIQync8Qz9oFAphTObc.GMLLI+ITZ9jKWNzzA7+HAW4Mipo5H3kWdLUWFdBTQUjtsU9+7ERIUaHHSdm2rDrnRmspKCaQmmII5o+666WWk1LhCog.GUEYU3fpHSSSrm377DbL7L.93svqy05wmvDewA8eUQ.JtYDGSCAQDnJRNzQmx2FBxhs7dUfnyIrpKCaVbnCfB...7PRDEDUQacj.29Np4Dy7uAQoaV2Lr0kQC....PRE4DQtJDXBB" ],
					"embed" : 1,
					"id" : "obj-19",
					"maxclass" : "fpic",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "jit_matrix" ],
					"patching_rect" : [ 53.5, 130.5, 268.0, 397.0 ],
					"pic" : "concert_mode.png",
					"presentation" : 1,
					"presentation_rect" : [ 43.5, 53.25, 296.0, 458.75 ],
					"varname" : "venueMode"
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"destination" : [ "obj-2", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-1", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-73", 17 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-100", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-98", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-101", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-75", 6 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-104", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-97", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-105", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-75", 7 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-106", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-113", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-107", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-69", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-108", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-73", 22 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-108", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-18", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-11", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-73", 21 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-110", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-73", 19 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-112", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-105", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-113", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-73", 13 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-116", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-73", 20 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-118", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-57", 20 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-120", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-79", 17 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-123", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-79", 18 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-125", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-50", 16 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-127", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-28", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-13", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-29", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-13", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-79", 16 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-130", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-78", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-132", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-79", 21 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-132", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-79", 20 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-134", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-50", 15 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-136", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-75", 9 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-138", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-57", 19 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-143", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-171", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-146", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-57", 18 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-147", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-73", 9 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-150", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-57", 21 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-151", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-191", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-152", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-57", 22 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-153", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-79", 11 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-155", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-79", 9 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-157", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-79", 10 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-159", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-13", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-16", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-79", 13 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-160", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-75", 17 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-164", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-75", 16 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-166", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-50", 14 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-168", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-12", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-17", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-79", 3 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-170", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-79", 12 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-176", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-79", 7 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-178", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-12", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-18", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-85", 16 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-180", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-85", 20 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-182", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-85", 17 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-184", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-85", 19 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-186", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-85", 14 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-188", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-64", 18 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-193", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-79", 2 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-196", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-10", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-2", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-26", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-20", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-85", 10 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-200", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-53", 14 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-203", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-77", 18 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-206", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-85", 8 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-207", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-85", 13 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-208", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-70", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-21", 0 ],
					"watchpoint_flags" : 1,
					"watchpoint_id" : 10
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-85", 18 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-211", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-85", 15 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-212", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-85", 11 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-214", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-85", 12 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-216", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-85", 6 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-220", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-57", 17 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-222", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-61", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-222", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-85", 9 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-224", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-85", 7 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-226", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-85", 5 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-228", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-77", 16 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-232", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-57", 16 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-235", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-53", 13 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-236", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-79", 14 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-24", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-75", 15 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-240", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-79", 8 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-242", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-50", 18 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-245", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-52", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-245", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-53", 21 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-247", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-32", 22 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-249", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-46", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-25", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-50", 19 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-251", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-53", 11 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-251", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-53", 22 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-253", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-54", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-253", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-53", 19 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-255", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-53", 20 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-256", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-53", 18 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-259", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-53", 17 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-260", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-53", 10 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-262", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-53", 15 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-265", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-53", 16 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-266", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-50", 13 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-268", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-5", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-27", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-50", 13 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-270", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-79", 6 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-273", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-50", 11 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-274", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-50", 17 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-278", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-20", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-28", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-50", 21 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-281", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-53", 7 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-281", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-53", 8 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-283", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-75", 22 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-286", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-53", 12 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-288", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-9", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-29", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-32", 15 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-290", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-77", 22 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-293", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-32", 16 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-295", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-309", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-297", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-27", 1 ],
					"disabled" : 0,
					"hidden" : 0,
					"midpoints" : [ 77.0, 1224.5, 214.5, 1224.5 ],
					"source" : [ "obj-3", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-27", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-3", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-79", 15 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-30", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-75", 19 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-300", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-32", 18 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-303", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-32", 21 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-305", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-32", 19 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-307", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-366", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-309", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-3", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"midpoints" : [ 138.5, 1181.5, 36.5, 1181.5 ],
					"source" : [ "obj-31", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-32", 17 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-310", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-313", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-312", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-314", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-313", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-32", 13 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-317", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-64", 13 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-317", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-64", 12 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-319", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-249", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-32", 8 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-290", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-32", 6 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-295", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-32", 4 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-303", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-32", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-305", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-32", 2 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-307", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-32", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-310", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-32", 3 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-317", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-32", 7 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-333", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-32", 9 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-64", 15 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-321", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-64", 16 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-323", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-64", 17 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-325", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-64", 14 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-327", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-64", 21 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-329", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-315", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-330", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-32", 20 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-333", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-43", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-333", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-75", 11 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-335", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-80", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-336", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-85", 21 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-336", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-64", 20 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-339", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-73", 12 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-34", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-64", 22 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-341", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-75", 20 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-342", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-77", 17 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-344", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-77", 14 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-346", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-77", 13 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-348", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-75", 14 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-35", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-74", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-351", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-75", 3 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-351", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-75", 4 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-353", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-77", 15 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-354", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-77", 21 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-356", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-77", 20 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-359", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-73", 11 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-36", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-64", 19 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-361", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-65", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-361", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-312", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-364", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-364", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-366", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-383", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-371", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-79", 5 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-376", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-79", 4 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-378", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-75", 13 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-38", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-75", 12 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-381", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-388", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-382", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-382", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-383", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-384", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-387", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-390", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-388", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-13", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-39", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-386", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-390", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-371", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-391", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-79", 22 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-393", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-75", 18 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-394", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-401", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-395", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-399", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-396", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-399", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-397", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-398", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-399", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-15", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-4", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-401", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-400", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-403", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-401", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-77", 19 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-405", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-40", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-41", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-76", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-42", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-77", 12 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-42", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-414", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-424", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-424", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-426", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-429", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-427", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-32", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-43", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-49", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-44", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-3", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-46", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-82", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"midpoints" : [ 106.0, 1186.0, 1546.25, 1186.0, 1546.25, -21.0, 1418.5, -21.0 ],
					"source" : [ "obj-46", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-49", 1 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-47", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-49", 2 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-48", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-21", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-5", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-127", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-50", 18 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-136", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-50", 17 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-168", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-50", 16 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-245", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-50", 22 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-251", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-50", 23 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-268", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-50", 14 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-270", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-50", 15 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-274", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-50", 20 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-278", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-50", 19 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-281", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-50", 12 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-45", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-51", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-50", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-52", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-203", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-53", 20 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-236", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-53", 19 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-247", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-53", 17 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-251", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-53", 23 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-253", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-53", 18 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-255", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-53", 15 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-256", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-53", 16 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-259", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-53", 14 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-260", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-53", 13 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-262", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-53", 10 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-265", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-53", 21 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-266", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-53", 22 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-281", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-53", 6 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-283", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-53", 11 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-288", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-53", 12 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-53", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-54", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-75", 10 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-55", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-73", 16 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-56", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-120", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-57", 17 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-143", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-57", 20 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-147", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-57", 21 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-151", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-57", 19 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-153", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-57", 18 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-222", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-57", 22 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-235", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-57", 23 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-426", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-59", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-4", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-6", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-73", 6 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-60", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-57", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-61", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-66", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-62", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-62", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-63", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-193", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-64", 19 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-317", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-64", 14 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-319", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-64", 13 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-321", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-64", 17 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-323", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-64", 16 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-325", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-64", 18 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-327", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-64", 15 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-329", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-64", 23 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-339", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-64", 22 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-341", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-64", 21 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-361", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-64", 20 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-365", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-64", 4 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-64", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-65", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-73", 7 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-67", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-75", 5 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-68", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-73", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-69", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-85", 22 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-7", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-79", 19 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-72", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-100", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-73", 20 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-108", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-73", 5 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-110", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-73", 23 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-112", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-73", 22 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-116", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-73", 16 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-118", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-73", 6 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-150", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-73", 12 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-34", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-73", 15 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-36", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-73", 14 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-56", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-73", 19 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-60", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-73", 9 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-67", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-73", 10 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-84", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-73", 18 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-93", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-73", 11 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-95", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-73", 13 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-99", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-73", 8 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-75", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-74", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-104", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-75", 5 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-106", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-75", 6 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-138", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-75", 18 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-164", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-75", 15 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-166", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-75", 14 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-238", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-75", 13 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-240", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-75", 12 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-286", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-75", 3 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-300", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-75", 21 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-335", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-75", 8 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-342", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-75", 23 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-35", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-75", 11 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-351", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-75", 19 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-353", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-75", 20 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-38", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-75", 10 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-381", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-75", 9 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-394", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-75", 16 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-55", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-75", 7 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-68", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-75", 4 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-96", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-75", 22 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-77", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-76", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-206", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-77", 20 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-232", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-77", 14 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-293", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-77", 23 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-344", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-77", 18 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-346", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-77", 16 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-348", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-77", 15 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-354", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-77", 17 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-356", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-77", 22 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-359", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-77", 21 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-405", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-77", 19 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-42", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-77", 13 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-79", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-78", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-123", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-79", 11 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-125", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-79", 10 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-130", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-79", 12 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-132", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-79", 9 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-134", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-79", 8 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-155", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-79", 6 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-157", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-79", 4 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-159", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-79", 5 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-160", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-79", 15 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-170", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-79", 22 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-176", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-79", 18 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-178", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-79", 16 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-194", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-79", 3 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-196", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-79", 23 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-24", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-79", 14 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-242", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-79", 17 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-273", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-79", 21 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-30", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-79", 13 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-376", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-79", 20 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-378", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-79", 19 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-393", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-79", 2 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-72", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-79", 7 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-17", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-8", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-85", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-80", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-3", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"midpoints" : [ 1291.5, 1031.5, 36.5, 1031.5 ],
					"source" : [ "obj-81", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-25", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"midpoints" : [ 1272.5, 1056.0, 28.0, 1056.0 ],
					"source" : [ "obj-83", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-73", 15 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-84", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-180", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-85", 18 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-182", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-85", 20 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-184", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-85", 17 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-186", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-85", 21 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-188", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-85", 16 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-200", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-85", 12 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-207", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-85", 10 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-208", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-85", 14 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-211", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-85", 19 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-212", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-85", 15 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-214", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-85", 13 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-216", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-85", 5 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-220", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-85", 9 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-224", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-85", 11 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-226", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-85", 8 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-228", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-85", 7 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-336", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-85", 22 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-369", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-85", 23 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-7", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-85", 6 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-87", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-86", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-88", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-89", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-20", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-9", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-92", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-91", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-73", 8 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-93", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-103", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-94", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-73", 10 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-95", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-75", 21 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-96", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-94", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-98", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-73", 5 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-99", 0 ]
				}

			}
 ],
		"dependency_cache" : [ 			{
				"name" : "concert_mode.png",
				"bootpath" : "~/Documents/watchdog/Show_Automation",
				"type" : "PNG ",
				"implicit" : 1
			}
, 			{
				"name" : "floorplan-bothfloors_1200.png",
				"bootpath" : "~/Documents/Max 7/Library/Show Automation",
				"type" : "PNG ",
				"implicit" : 1
			}
, 			{
				"name" : "watchGod.js",
				"bootpath" : "~/Documents/watchdog/Show_Automation",
				"type" : "TEXT",
				"implicit" : 1
			}
, 			{
				"name" : "watchGod_returnsNone.js",
				"bootpath" : "~/Documents/Max 7/Library/watchdog",
				"type" : "TEXT",
				"implicit" : 1
			}
, 			{
				"name" : "Panel-2LBmapping.txt",
				"bootpath" : "~/Documents/Max 7/Library/Show Automation",
				"type" : "TEXT",
				"implicit" : 1
			}
, 			{
				"name" : "Panel-2LCmapping.txt",
				"bootpath" : "~/Documents/Max 7/Library/Show Automation",
				"type" : "TEXT",
				"implicit" : 1
			}
, 			{
				"name" : "Panel-2LDmapping.txt",
				"bootpath" : "~/Documents/Max 7/Library/Show Automation",
				"type" : "TEXT",
				"implicit" : 1
			}
, 			{
				"name" : "node.maxpat",
				"bootpath" : "~/Documents/watchdog/Show_Automation",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "watchDogWindow-piChild.maxpat",
				"bootpath" : "~/Documents/watchdog/Show_Automation",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "watchDogWindow.maxpat",
				"bootpath" : "~/Documents/watchdog/Show_Automation",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "turnPoEOn.maxpat",
				"bootpath" : "~/Documents/watchdog/Show_Automation",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "remoteLogin.maxpat",
				"bootpath" : "~/Documents/watchdog/Show_Automation",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "watchgod.js",
				"bootpath" : "~/Documents/watchdog/Show_Automation",
				"type" : "TEXT",
				"implicit" : 1
			}
, 			{
				"name" : "searchBox.maxpat",
				"bootpath" : "~/Documents/watchdog/Show_Automation",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "openButton.maxpat",
				"bootpath" : "~/Documents/Max 7/Library/Show Automation",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "searchTest.maxpat",
				"bootpath" : "~/Documents/Max 7/Library/watchdog",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "watchGod_search.js",
				"bootpath" : "~/Documents/Max 7/Library/watchdog",
				"type" : "TEXT",
				"implicit" : 1
			}
, 			{
				"name" : "serverStatus.maxpat",
				"bootpath" : "~/Documents/Max 7/Library/Show Automation",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "relayPanelGUI.maxpat",
				"bootpath" : "~/Documents/Max 7/Library/Show Automation",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "advancedPower.maxpat",
				"bootpath" : "~/Documents/watchdog/Show_Automation",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "onOffBySwitch.maxpat",
				"bootpath" : "~/Documents/Max 7/Library/Show Automation",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "onOffByZone.maxpat",
				"bootpath" : "~/Documents/Max 7/Library/Show Automation",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "onOffByDeviceType.maxpat",
				"bootpath" : "~/Documents/Max 7/Library/Show Automation",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "portalsDoorSendHelp.maxpat",
				"bootpath" : "~/Documents/Max 7/Library/Show Automation",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "reporter.js",
				"bootpath" : "~/Documents/Max 7/Library/Show Automation",
				"type" : "TEXT",
				"implicit" : 1
			}
, 			{
				"name" : "restartPOD.maxpat",
				"bootpath" : "~/Documents/Max 7/Library/Show Automation",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "sendPlayToAbleton.maxpat",
				"bootpath" : "~/Documents/Max 7/Library/Show Automation",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "volumeReadback.maxpat",
				"bootpath" : "~/Documents/Max 7/Library/Show Automation",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "piVolumes.maxpat",
				"bootpath" : "~/Documents/Max 7/Library/Show Automation",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "blinkBGGreen.maxpat",
				"bootpath" : "~/Documents/Max 7/Library/Show Automation",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "blinkBGRed.maxpat",
				"bootpath" : "~/Documents/Max 7/Library/Show Automation",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "wakeMacOS.maxpat",
				"bootpath" : "~/Documents/Max 7/Library/Show Automation",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "areaStatus.maxpat",
				"bootpath" : "~/Documents/watchdog/Show_Automation",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "colorbox.js",
				"bootpath" : "~/Documents/Max 7/Library/Show Automation",
				"type" : "TEXT",
				"implicit" : 1
			}
, 			{
				"name" : "checkNVR.maxpat",
				"bootpath" : "~/Documents/watchdog/Show_Automation",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "OSC-route.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "shell.mxo",
				"type" : "iLaX"
			}
 ],
		"embedsnapshot" : 0,
		"styles" : [ 			{
				"name" : "AudioStatus_Menu",
				"default" : 				{
					"bgfillcolor" : 					{
						"type" : "color",
						"color" : [ 0.294118, 0.313726, 0.337255, 1 ],
						"color1" : [ 0.454902, 0.462745, 0.482353, 0.0 ],
						"color2" : [ 0.290196, 0.309804, 0.301961, 1.0 ],
						"angle" : 270.0,
						"proportion" : 0.39,
						"autogradient" : 0
					}

				}
,
				"parentstyle" : "",
				"multi" : 0
			}
, 			{
				"name" : "bw-umenu",
				"default" : 				{
					"fontsize" : [ 12.0 ],
					"fontname" : [ "Arial" ]
				}
,
				"parentstyle" : "",
				"multi" : 0
			}
, 			{
				"name" : "bw.textbutton01",
				"default" : 				{
					"selectioncolor" : [ 0.317647, 0.654902, 0.976471, 1.0 ],
					"fontsize" : [ 12.0 ],
					"accentcolor" : [ 0.803922, 0.898039, 0.909804, 1.0 ],
					"fontname" : [ "Arial" ]
				}
,
				"parentstyle" : "",
				"multi" : 0
			}
, 			{
				"name" : "bw.umenu01",
				"default" : 				{
					"fontsize" : [ 12.0 ],
					"fontname" : [ "Arial" ]
				}
,
				"parentstyle" : "",
				"multi" : 0
			}
 ]
	}

}
