Panel_Building_WorkManager:setMaskingChild(true)
Panel_Building_WorkManager:setGlassBackground(true)
Panel_Building_WorkManager:TEMP_UseUpdateListSwap(true)
Panel_Building_WorkManager:ActiveMouseEventEffect( true )

local UI_PP 		= CppEnums.PAUIMB_PRIORITY

local buildingActorKey	= nil
local affiliatedTownKey	= 0
local houseParam 		= nil

-----------------------------------------------------
-- 최초 'defalut_Control' Setting 관련 함수
-----------------------------------------------------

local defalut_Control =
{
	_title						= UI.getChildControl( Panel_Building_WorkManager, "StaticText_Title" ),
	_btn_Close					= UI.getChildControl( Panel_Building_WorkManager, "Button_Win_Close" ),
	_btn_Question				= UI.getChildControl( Panel_Building_WorkManager, "Button_Question" ),
		
	_building_Info =	
	{	
		_BG						= UI.getChildControl( Panel_Building_WorkManager, "Static_Building_BG" ),
		_Btn_Cancel				= UI.getChildControl( Panel_Building_WorkManager, "Button_Building_Cancel" ),
		_Icon_BG_1				= UI.getChildControl( Panel_Building_WorkManager, "Static_Building_Result_Icon_BG_1" ),
		_Icon_BG_2				= UI.getChildControl( Panel_Building_WorkManager, "Static_Building_Result_Icon_BG_2" ),
		_Icon					= UI.getChildControl( Panel_Building_WorkManager, "Static_Building_Result_Icon" ),
		_Name					= UI.getChildControl( Panel_Building_WorkManager, "StaticText_Building_Name" ),
		_Current_Count         	= UI.getChildControl( Panel_Building_WorkManager, "StaticText_Building_CurrentCount" ),
		_Progress_BG           	= UI.getChildControl( Panel_Building_WorkManager, "Static_Building_Progress_BG" ),
		_Progress_OutLine      	= UI.getChildControl( Panel_Building_WorkManager, "Static_Building_Progress_OutLine" ),
		_Progress_OnGoing      	= UI.getChildControl( Panel_Building_WorkManager, "Progress2_Building_OnGoing" ),
		_Progress_Complete     	= UI.getChildControl( Panel_Building_WorkManager, "Progress2_Building_Complete" ),
	},	
		
	_subWork_List =	
	{	
		_BG						= UI.getChildControl( Panel_Building_WorkManager, "Static_SubWorkList_BG" ),
		_Title              	= UI.getChildControl( Panel_Building_WorkManager, "StaticText_SubWorkList_Title" ),
		_Scroll             	= UI.getChildControl( Panel_Building_WorkManager, "Scroll_SubWorkList" ),
		_Button              	= {},
		_Progress_OnGoing       = {},
		_Progress_Complete      = {},
		_CountText_1      		= {},
		_CountText_2      		= {},
		_Ani_OnGoing       		= {},
			
		_Template =	
		{	
			_Button				= UI.getChildControl( Panel_Building_WorkManager, "RadioButton_SubWork" ),
			_Progress_OnGoing  	= UI.getChildControl( Panel_Building_WorkManager, "Progress2_SubWorkList_OnGoing" ),
			_Progress_Complete 	= UI.getChildControl( Panel_Building_WorkManager, "Progress2_SubWorkList_Complete" ),
			_CountText_1	 	= UI.getChildControl( Panel_Building_WorkManager, "StaticText_SubWorkList_Count_1" ),
			_CountText_2	 	= UI.getChildControl( Panel_Building_WorkManager, "StaticText_SubWorkList_Count_2" ),
			_Ani_OnGoing	 	= UI.getChildControl( Panel_Building_WorkManager, "Static_SubWorkList_OnGoingAni" ),
			
			_rowMax = 7,
			_row_PosY_Gap = 1,
		},	
	},	
		
	_worker_List =	
	{	
		_BG						= UI.getChildControl( Panel_Building_WorkManager, "Static_WorkerList_BG" ),
		_Title              	= UI.getChildControl( Panel_Building_WorkManager, "StaticText_WorkerList_Title" ),
		_Scroll             	= UI.getChildControl( Panel_Building_WorkManager, "Scroll_WorkerList" ),
		_No_Worker             	= UI.getChildControl( Panel_Building_WorkManager, "StaticText_NoWorker" ),
		_Button             	= {},
		_Progress           	= {},
		_ActionPoint           	= {},
			
		_Template =	
		{	
			_Button				= UI.getChildControl( Panel_Building_WorkManager, "RadioButton_Worker" ),
			_Progress       	= UI.getChildControl( Panel_Building_WorkManager, "Progress2_Worker_ActionPoint" ),
			_ActionPoint       	= UI.getChildControl( Panel_Building_WorkManager, "StaticText_Worker_ActionPoint" ),
			
			_rowMax = 7,
			_row_PosY_Gap = 1,
		},	
	},	
	
	_subWork_Info =	
	{	
		_BG						= UI.getChildControl( Panel_Building_WorkManager, "Static_SubWorkInfo_BG" ),
		_Title              	= UI.getChildControl( Panel_Building_WorkManager, "StaticText_SubWorkInfo_Title" ),
								
		_Resource_BG        	= UI.getChildControl( Panel_Building_WorkManager, "Static_SubWorkInfo_Resource_BG" ),
		_Resource_Title     	= UI.getChildControl( Panel_Building_WorkManager, "StaticText_SubWorkInfo_Resource_Title" ),
		_Resource_Name     		= UI.getChildControl( Panel_Building_WorkManager, "StaticText_SubWorkInfo_Resource_Name" ),
		_Resource_Icon_BG   	= UI.getChildControl( Panel_Building_WorkManager, "StaticText_SubWorkInfo_Resource_Icon_BG" ),
		_Resource_Icon_Border 	= UI.getChildControl( Panel_Building_WorkManager, "StaticText_SubWorkInfo_Resource_Icon_Border" ),
		_Resource_Icon_Over   	= UI.getChildControl( Panel_Building_WorkManager, "StaticText_SubWorkInfo_Resource_Icon_Over" ),
		_Resource_Icon      	= UI.getChildControl( Panel_Building_WorkManager, "StaticText_SubWorkInfo_Resource_Icon" ),
		_Resource_Count     	= UI.getChildControl( Panel_Building_WorkManager, "StaticText_SubWorkInfo_Resource_Count" ),
		_Resource_Line_1    	= UI.getChildControl( Panel_Building_WorkManager, "Static_SubWorkInfo_Resource_Line_1" ),
		_Resource_Line_2    	= UI.getChildControl( Panel_Building_WorkManager, "Static_SubWorkInfo_Resource_Line_2" ),
		
		_OnGoing_BG          	= UI.getChildControl( Panel_Building_WorkManager, "Static_SubWorkInfo_OnGoing_BG" ),
		_OnGoing_Title       	= UI.getChildControl( Panel_Building_WorkManager, "StaticText_SubWorkInfo_OnGoing_Title" ),
		_OnGoing_Scroll       	= UI.getChildControl( Panel_Building_WorkManager, "Scroll_SubWorkInfo_OnGoing" ),
		_OnGoing_Line_1      	= UI.getChildControl( Panel_Building_WorkManager, "Static_SubWorkInfo_OnGoing_Line_1" ),
		_OnGoing_Line_2      	= UI.getChildControl( Panel_Building_WorkManager, "Static_SubWorkInfo_OnGoing_Line_2" ),
		_OnGoing_Guide        	= UI.getChildControl( Panel_Building_WorkManager, "StaticText_SubWorkInfo_OnGoing_Guide" ),
		
		_OnGoing_Time	     	= {},
		_OnGoing_Progress_BG   	= {},
		_OnGoing_Progress     	= {},
		_OnGoing_Cancel     	= {},
								
		_Template =
		{
			_OnGoing_Time	     	= UI.getChildControl( Panel_Building_WorkManager, "StaticText_SubWorkInfo_Ongoing_Time" ),
			_OnGoing_Progress_BG   	= UI.getChildControl( Panel_Building_WorkManager, "Static_SubWorkInfo_OnGoing_Progress_BG" ),
			_OnGoing_Progress     	= UI.getChildControl( Panel_Building_WorkManager, "Progress2_SubWorkInfo_OnGoing" ),
			_OnGoing_Cancel     	= UI.getChildControl( Panel_Building_WorkManager, "Button_SubWorkInfo_Cancel" ),
			
			_rowMax = 4,
			_row_PosY_Gap = 5,
		},
	},

	_subWork_Estimated =
	{
		_BG						= UI.getChildControl( Panel_Building_WorkManager, "Static_Estimated_BG" ),
		_Title                  = UI.getChildControl( Panel_Building_WorkManager, "StaticText_Estimated_Title" ),
		                        
		_Time_BG                = UI.getChildControl( Panel_Building_WorkManager, "Static_Estimated_Time_BG" ),
		_Time_Text              = UI.getChildControl( Panel_Building_WorkManager, "StaticText_Estimated_Time_Text" ),
		_Time_Value             = UI.getChildControl( Panel_Building_WorkManager, "StaticText_Estimated_Time_Value" ),
		_Time_Count             = UI.getChildControl( Panel_Building_WorkManager, "StaticText_Estimated_Time_Count" ),
		_Time_Line              = UI.getChildControl( Panel_Building_WorkManager, "Static_Estimated_Time_Line" ),
		_Work_Count				= UI.getChildControl( Panel_Building_WorkManager, "Button_Estimated_Work_Count" ),
		                        
		_Work_BG                = UI.getChildControl( Panel_Building_WorkManager, "Static_Estimated_Work_BG" ),
		_Work_Line_1            = UI.getChildControl( Panel_Building_WorkManager, "Static_Estimated_Work_Line_1" ),
		_Work_Line_2            = UI.getChildControl( Panel_Building_WorkManager, "Static_Estimated_Work_Line_2" ),
		_Work_Volume_Text       = UI.getChildControl( Panel_Building_WorkManager, "StaticText_Estimated_WorkVolum_Text" ),
		_Work_Volume_Value      = UI.getChildControl( Panel_Building_WorkManager, "StaticText_Estimated_WorkVolum_Value" ),
		_Work_Speed_Text        = UI.getChildControl( Panel_Building_WorkManager, "StaticText_Estimated_WorkSpeed_Text" ),
		_Work_Speed_Value       = UI.getChildControl( Panel_Building_WorkManager, "StaticText_Estimated_WorkSpeed_Value" ),
		                        
		_Move_BG                = UI.getChildControl( Panel_Building_WorkManager, "Static_Estimated_Move_BG" ),
		_Move_Line_1            = UI.getChildControl( Panel_Building_WorkManager, "Static_Estimated_Move_Line_1" ),
		_Move_Line_2            = UI.getChildControl( Panel_Building_WorkManager, "Static_Estimated_Move_Line_2" ),
		_Move_Distance_Text     = UI.getChildControl( Panel_Building_WorkManager, "StaticText_Estimated_MoveDistance_Text" ),
		_Move_Distance_Value    = UI.getChildControl( Panel_Building_WorkManager, "StaticText_Estimated_MoveDistance_Value" ),
		_Move_Speed_Text        = UI.getChildControl( Panel_Building_WorkManager, "StaticText_Estimated_MoveSpeed_Text" ),
		_Move_Speed_Value       = UI.getChildControl( Panel_Building_WorkManager, "StaticText_Estimated_MoveSpeed_Value" ),
		                        
		_Button_DoWork          = UI.getChildControl( Panel_Building_WorkManager, "Button_doWork" ),
		_Finished_Work		    = UI.getChildControl( Panel_Building_WorkManager, "StaticText_Finished_Work" ),
		_No_Resource_Work	    = UI.getChildControl( Panel_Building_WorkManager, "StaticText_noResource" ),

		_chk_IgnoreWorkingCount	= UI.getChildControl( Panel_Building_WorkManager, "CheckButton_IgnoreWorkingCount" ),
	},
}

defalut_Control._btn_Question:addInputEvent( "Mouse_LUp", "Panel_WebHelper_ShowToggle( \"HouseManageWork\" )" )				--물음표 좌클릭
defalut_Control._btn_Question:addInputEvent( "Mouse_On", "HelpMessageQuestion_Show( \"HouseManageWork\", \"true\")" )		--물음표 마우스오버
defalut_Control._btn_Question:addInputEvent( "Mouse_Out", "HelpMessageQuestion_Show( \"HouseManageWork\", \"false\")" )		--물음표 마우스아웃

function defalut_Control:Init_Control()

	FGlobal_AddChild(Panel_Building_WorkManager, self._building_Info._BG, self._building_Info._Btn_Cancel )
	FGlobal_AddChild(Panel_Building_WorkManager, self._building_Info._BG, self._building_Info._Icon_BG_1 )
	FGlobal_AddChild(Panel_Building_WorkManager, self._building_Info._BG, self._building_Info._Icon_BG_2 )
	FGlobal_AddChild(Panel_Building_WorkManager, self._building_Info._BG, self._building_Info._Icon )
	FGlobal_AddChild(Panel_Building_WorkManager, self._building_Info._BG, self._building_Info._Name )
	FGlobal_AddChild(Panel_Building_WorkManager, self._building_Info._BG, self._building_Info._Current_Count )
	FGlobal_AddChild(Panel_Building_WorkManager, self._building_Info._BG, self._building_Info._Progress_BG )
	FGlobal_AddChild(Panel_Building_WorkManager, self._building_Info._BG, self._building_Info._Progress_OutLine )
	FGlobal_AddChild(Panel_Building_WorkManager, self._building_Info._BG, self._building_Info._Progress_OnGoing )
	FGlobal_AddChild(Panel_Building_WorkManager, self._building_Info._BG, self._building_Info._Progress_Complete )

	FGlobal_AddChild(Panel_Building_WorkManager, self._subWork_List._BG, self._subWork_List._Title )
	FGlobal_AddChild(Panel_Building_WorkManager, self._subWork_List._BG, self._subWork_List._Scroll )	
	
	FGlobal_Set_Table_Control(self._subWork_List, "_Button", "_Button", true, false)
	FGlobal_Set_Table_Control(self._subWork_List, "_Ani_OnGoing", "_Button", true, false)
	FGlobal_Set_Table_Control(self._subWork_List, "_Progress_OnGoing", "_Button", true, false)
	FGlobal_Set_Table_Control(self._subWork_List, "_Progress_Complete", "_Button", true, false)
	FGlobal_Set_Table_Control(self._subWork_List, "_CountText_1", "_Button", true, false)
	FGlobal_Set_Table_Control(self._subWork_List, "_CountText_2", "_Button", true, false)
	
	FGlobal_AddChild(Panel_Building_WorkManager, self._worker_List._BG, self._worker_List._Title )
	FGlobal_AddChild(Panel_Building_WorkManager, self._worker_List._BG, self._worker_List._Scroll )
	FGlobal_AddChild(Panel_Building_WorkManager, self._worker_List._BG, self._worker_List._No_Worker )
	
	FGlobal_Set_Table_Control(self._worker_List, "_Button", "_Button", true, false)
	FGlobal_Set_Table_Control(self._worker_List, "_Progress", "_Button", true, false)
	FGlobal_Set_Table_Control(self._worker_List, "_ActionPoint", "_Button", true, false)

	FGlobal_AddChild(Panel_Building_WorkManager, self._subWork_Info._BG, self._subWork_Info._Title )
	FGlobal_AddChild(Panel_Building_WorkManager, self._subWork_Info._BG, self._subWork_Info._Resource_BG )
	FGlobal_AddChild(Panel_Building_WorkManager, self._subWork_Info._BG, self._subWork_Info._Resource_Title )
	FGlobal_AddChild(Panel_Building_WorkManager, self._subWork_Info._BG, self._subWork_Info._Resource_Name )
	FGlobal_AddChild(Panel_Building_WorkManager, self._subWork_Info._BG, self._subWork_Info._Resource_Icon_BG )
	FGlobal_AddChild(Panel_Building_WorkManager, self._subWork_Info._BG, self._subWork_Info._Resource_Icon_Border )
	FGlobal_AddChild(Panel_Building_WorkManager, self._subWork_Info._BG, self._subWork_Info._Resource_Icon_Over )
	FGlobal_AddChild(Panel_Building_WorkManager, self._subWork_Info._BG, self._subWork_Info._Resource_Icon )
	FGlobal_AddChild(Panel_Building_WorkManager, self._subWork_Info._BG, self._subWork_Info._Resource_Count )
	FGlobal_AddChild(Panel_Building_WorkManager, self._subWork_Info._BG, self._subWork_Info._Resource_Line_1 )
	FGlobal_AddChild(Panel_Building_WorkManager, self._subWork_Info._BG, self._subWork_Info._Resource_Line_2  )	
	FGlobal_AddChild(Panel_Building_WorkManager, self._subWork_Info._BG, self._subWork_Info._OnGoing_BG )
	FGlobal_AddChild(Panel_Building_WorkManager, self._subWork_Info._BG, self._subWork_Info._OnGoing_Title )
	FGlobal_AddChild(Panel_Building_WorkManager, self._subWork_Info._BG, self._subWork_Info._OnGoing_Scroll )
	FGlobal_AddChild(Panel_Building_WorkManager, self._subWork_Info._BG, self._subWork_Info._OnGoing_Line_1 )
	FGlobal_AddChild(Panel_Building_WorkManager, self._subWork_Info._BG, self._subWork_Info._OnGoing_Line_2 )
	FGlobal_AddChild(Panel_Building_WorkManager, self._subWork_Info._BG, self._subWork_Info._OnGoing_Guide )
	
	FGlobal_Set_Table_Control(self._subWork_Info, "_OnGoing_Time", "_OnGoing_Time", true, false)
	FGlobal_Set_Table_Control(self._subWork_Info, "_OnGoing_Progress_BG", "_OnGoing_Time", true, false)
	FGlobal_Set_Table_Control(self._subWork_Info, "_OnGoing_Progress", "_OnGoing_Time", true, false)
	FGlobal_Set_Table_Control(self._subWork_Info, "_OnGoing_Cancel", "_OnGoing_Time", true, false)

	FGlobal_AddChild(Panel_Building_WorkManager, self._subWork_Estimated._BG, self._subWork_Estimated._Title )	
	FGlobal_AddChild(Panel_Building_WorkManager, self._subWork_Estimated._BG, self._subWork_Estimated._Time_BG )
	FGlobal_AddChild(Panel_Building_WorkManager, self._subWork_Estimated._BG, self._subWork_Estimated._Time_Text )
	FGlobal_AddChild(Panel_Building_WorkManager, self._subWork_Estimated._BG, self._subWork_Estimated._Time_Value )
	FGlobal_AddChild(Panel_Building_WorkManager, self._subWork_Estimated._BG, self._subWork_Estimated._Time_Count )
	FGlobal_AddChild(Panel_Building_WorkManager, self._subWork_Estimated._BG, self._subWork_Estimated._Work_Count )
	FGlobal_AddChild(Panel_Building_WorkManager, self._subWork_Estimated._BG, self._subWork_Estimated._Time_Line )	
	FGlobal_AddChild(Panel_Building_WorkManager, self._subWork_Estimated._BG, self._subWork_Estimated._Work_BG )
	FGlobal_AddChild(Panel_Building_WorkManager, self._subWork_Estimated._BG, self._subWork_Estimated._Work_Line_1 ) 		
	FGlobal_AddChild(Panel_Building_WorkManager, self._subWork_Estimated._BG, self._subWork_Estimated._Work_Line_2 ) 		
	FGlobal_AddChild(Panel_Building_WorkManager, self._subWork_Estimated._BG, self._subWork_Estimated._Work_Volume_Text ) 	
	FGlobal_AddChild(Panel_Building_WorkManager, self._subWork_Estimated._BG, self._subWork_Estimated._Work_Volume_Value ) 	
	FGlobal_AddChild(Panel_Building_WorkManager, self._subWork_Estimated._BG, self._subWork_Estimated._Work_Speed_Text ) 	
	FGlobal_AddChild(Panel_Building_WorkManager, self._subWork_Estimated._BG, self._subWork_Estimated._Work_Speed_Value ) 		
	FGlobal_AddChild(Panel_Building_WorkManager, self._subWork_Estimated._BG, self._subWork_Estimated._Move_BG )
	FGlobal_AddChild(Panel_Building_WorkManager, self._subWork_Estimated._BG, self._subWork_Estimated._Move_Line_1 )			
	FGlobal_AddChild(Panel_Building_WorkManager, self._subWork_Estimated._BG, self._subWork_Estimated._Move_Line_2 ) 		
	FGlobal_AddChild(Panel_Building_WorkManager, self._subWork_Estimated._BG, self._subWork_Estimated._Move_Distance_Text )
	FGlobal_AddChild(Panel_Building_WorkManager, self._subWork_Estimated._BG, self._subWork_Estimated._Move_Distance_Value ) 
	FGlobal_AddChild(Panel_Building_WorkManager, self._subWork_Estimated._BG, self._subWork_Estimated._Move_Speed_Text ) 	
	FGlobal_AddChild(Panel_Building_WorkManager, self._subWork_Estimated._BG, self._subWork_Estimated._Move_Speed_Value ) 	
	FGlobal_AddChild(Panel_Building_WorkManager, self._subWork_Estimated._BG, self._subWork_Estimated._Button_DoWork )
	FGlobal_AddChild(Panel_Building_WorkManager, self._subWork_Estimated._BG, self._subWork_Estimated._Finished_Work )
	FGlobal_AddChild(Panel_Building_WorkManager, self._subWork_Estimated._BG, self._subWork_Estimated._No_Resource_Work )
end
defalut_Control:Init_Control()

function defalut_Control:Init_Function()
	self._btn_Close									:addInputEvent("Mouse_LUp",			"FGlobal_Building_WorkManager_Close()")
		
	self._subWork_List._Scroll						:addInputEvent("Mouse_UpScroll",	"HandleScroll_Building_SubWork_List_UpDown(true)")
	self._subWork_List._Scroll						:addInputEvent("Mouse_DownScroll",	"HandleScroll_Building_SubWork_List_UpDown(false)")
	self._subWork_List._Scroll						:addInputEvent("Mouse_LUp",			"HandleScroll_Building_SubWork_List_OnClick()")
	self._subWork_List._Scroll						:addInputEvent("Mouse_LDown",		"HandleScroll_Building_SubWork_List_OnClick()")
	self._subWork_List._Scroll:GetControlButton()	:addInputEvent("Mouse_UpScroll",	"HandleScroll_Building_SubWork_List_UpDown(true)")
	self._subWork_List._Scroll:GetControlButton()	:addInputEvent("Mouse_DownScroll",	"HandleScroll_Building_SubWork_List_UpDown(false)")
	self._subWork_List._Scroll:GetControlButton()	:addInputEvent("Mouse_LUp",			"HandleScroll_Building_SubWork_List_OnClick()")
	self._subWork_List._Scroll:GetControlButton()	:addInputEvent("Mouse_LDown",		"HandleScroll_Building_SubWork_List_OnClick()")
	self._subWork_List._Scroll:GetControlButton()	:addInputEvent("Mouse_LPress",		"HandleScroll_Building_SubWork_List_OnClick()")
	

	for key, value in pairs (self._subWork_List._Button) do
		value:addInputEvent("Mouse_LUp",		"Building_Work_List_Select(" .. tostring(key) ..")")
		value:addInputEvent("Mouse_On",			"HandleOn_Building_SubWork_List(" .. tostring(key) ..")")
		value:addInputEvent("Mouse_Out",		"HandleOut_Building_SubWork_List()")
		value:addInputEvent("Mouse_UpScroll",	"HandleScroll_Building_SubWork_List_UpDown(true)")
		value:addInputEvent("Mouse_DownScroll",	"HandleScroll_Building_SubWork_List_UpDown(false)")
	end
	
	self._worker_List._BG						:addInputEvent("Mouse_UpScroll",	"HandleScroll_Building_Worker_List_UpDown(true)")
	self._worker_List._BG						:addInputEvent("Mouse_DownScroll",	"HandleScroll_Building_Worker_List_UpDown(false)")
	                                            
	self._worker_List._Scroll					:addInputEvent("Mouse_UpScroll",	"HandleScroll_Building_Worker_List_UpDown(true)")
	self._worker_List._Scroll					:addInputEvent("Mouse_DownScroll",	"HandleScroll_Building_Worker_List_UpDown(false)")
	self._worker_List._Scroll					:addInputEvent("Mouse_LDown",		"HandleScroll_Building_Worker_List_OnClick()")
	self._worker_List._Scroll					:addInputEvent("Mouse_LUp",			"HandleScroll_Building_Worker_List_OnClick()")
	self._worker_List._Scroll:GetControlButton():addInputEvent("Mouse_UpScroll",	"HandleScroll_Building_Worker_List_UpDown(true)")	
	self._worker_List._Scroll:GetControlButton():addInputEvent("Mouse_DownScroll",	"HandleScroll_Building_Worker_List_UpDown(false)")	
	self._worker_List._Scroll:GetControlButton():addInputEvent("Mouse_LDown",		"HandleScroll_Building_Worker_List_OnClick()")	
	self._worker_List._Scroll:GetControlButton():addInputEvent("Mouse_LUp",			"HandleScroll_Building_Worker_List_OnClick()")	
	self._worker_List._Scroll:GetControlButton():addInputEvent("Mouse_LPress",		"HandleScroll_Building_Worker_List_OnClick()")	

	for key, value in pairs (self._worker_List._Button) do
		value:addInputEvent("Mouse_LUp",		"Building_Worker_List_Select(" .. key ..")")
		value:addInputEvent("Mouse_On",			"HandleOn_Building_Worker_List(" .. key ..")")
		value:addInputEvent("Mouse_Out",		"HandleOut_Building_Worker_List()")
		value:addInputEvent("Mouse_UpScroll",	"HandleScroll_Building_Worker_List_UpDown(true)")
		value:addInputEvent("Mouse_DownScroll",	"HandleScroll_Building_Worker_List_UpDown(false)")
	end
	self._subWork_Info._OnGoing_BG				:addInputEvent("Mouse_UpScroll",	"HandleScroll_Building_SubWork_Progress_List_UpDown(true)")
	self._subWork_Info._OnGoing_BG				:addInputEvent("Mouse_DownScroll",	"HandleScroll_Building_SubWork_Progress_List_UpDown(false)")

	self._subWork_Info._OnGoing_Scroll						:addInputEvent("Mouse_UpScroll",	"HandleScroll_Building_SubWork_Progress_List_UpDown(true)")
	self._subWork_Info._OnGoing_Scroll						:addInputEvent("Mouse_DownScroll",	"HandleScroll_Building_SubWork_Progress_List_UpDown(false)")
	self._subWork_Info._OnGoing_Scroll						:addInputEvent("Mouse_LDown",		"HandleScroll_Building_SubWork_Progress_List_OnClick()")
	self._subWork_Info._OnGoing_Scroll						:addInputEvent("Mouse_LUp",			"HandleScroll_Building_SubWork_Progress_List_OnClick()")
	self._subWork_Info._OnGoing_Scroll:GetControlButton()	:addInputEvent("Mouse_UpScroll",	"HandleScroll_Building_SubWork_Progress_List_UpDown(true)")	
	self._subWork_Info._OnGoing_Scroll:GetControlButton()	:addInputEvent("Mouse_DownScroll",	"HandleScroll_Building_SubWork_Progress_List_UpDown(false)")	
	self._subWork_Info._OnGoing_Scroll:GetControlButton()	:addInputEvent("Mouse_LDown",		"HandleScroll_Building_SubWork_Progress_List_OnClick()")	
	self._subWork_Info._OnGoing_Scroll:GetControlButton()	:addInputEvent("Mouse_LUp",			"HandleScroll_Building_SubWork_Progress_List_OnClick()")	
	self._subWork_Info._OnGoing_Scroll:GetControlButton()	:addInputEvent("Mouse_LPress",		"HandleScroll_Building_SubWork_Progress_List_OnClick()")	

	self._subWork_Info._Resource_Icon_Over		:addInputEvent("Mouse_On",			"Item_Tooltip_Show_Building()")
	self._subWork_Info._Resource_Icon_Over		:addInputEvent("Mouse_Out",			"Panel_Tooltip_Item_hideTooltip()")
	
	for key, value in pairs (self._subWork_Info._OnGoing_Cancel) do
		value:addInputEvent("Mouse_LUp", "HandleClick_OnGoing_Cancel_Building(" .. tostring(key) .. ")")
	end

	self._subWork_Estimated._Work_Count				:addInputEvent("Mouse_LUp", "HandleClicked_WorkCount_Building()")
	self._subWork_Estimated._Button_DoWork			:addInputEvent("Mouse_LUp",	"HandleClick_doWork_Building()")
	self._subWork_Estimated._chk_IgnoreWorkingCount	:addInputEvent("Mouse_LUp",	"HandleClick_doWork_IgnoreWorkingCount()")
end
defalut_Control:Init_Function()

-----------------------------------------------------
-- 건설 작업 정보(Building Info) 관련 함수
-----------------------------------------------------

local Building_Info = 
{
	_name					= "",
	_icon					= "",
			
	_workVolum				= 0,
	_position				= 0,
			
	_count_Total			= 0,
	_count_Current			= 0,
	_count_onGoing			= 0,
	
	_subWork_Data 			= {},
}

local SubWork_List = {}

function Building_Info:_setData(isRefresh)

	local	buildingInfoSS	= ToClient_getBuildingInfo( buildingActorKey ); 

	if( nil == buildingInfoSS ) then
		return;
	end

	local buildProgress	= buildingInfoSS:getBuildingProgress()
	local workCount		= ToClient_getBuildingWorkableListCount(buildingInfoSS)
	
	if workCount <= 0 then
		return
	end
	
	if buildProgress < 1 then
		
		--[[
		local houseActorWarpper	= getHouseHoldActor( buildingActorKey )
		if nil ~= houseActorWarpper then
			local expireTime		= houseActorWarpper:get():getExpiredTime()
			local lefttimeText		= convertStringFromDatetime(getLeftSecond_TTime64(expireTime))

			self._name =	PAGetStringParam2( Defines.StringSheet_GAME, "GAME_MESSAGE_HOUSE_HOD_NAME", "nickName", 
			ToClient_getBuildingOwnerName( buildingInfoSS ), "houseName", ToClient_getBuildTypeName( buildingInfoSS ) ) .. PAGetStringParam1( Defines.StringSheet_GAME, "LUA_CHARACTERNAMETAG_HOUSEHOLDNAME", "lefttimeText", lefttimeText ) -- ( <PAColor0xFFffe157>철거까지 남은 시간 : <PAColor0xFFff8787>" .. lefttimeText .. " <PAOldColor>)"
		else
			--self._name =	PAGetStringParam2( Defines.StringSheet_GAME, "GAME_MESSAGE_HOUSE_HOD_NAME", "nickName", 
			--ToClient_getBuildingOwnerName( buildingInfoSS ), "houseName", ToClient_getBuildTypeName( buildingInfoSS ) )
		end
		]]--
		
		local expireTime		= buildingInfoSS:getExpiredTime()
		local lefttime 			= getLeftSecond_TTime64(expireTime)
		local lefttimeText		= convertStringFromDatetime(lefttime)
		
		if( toInt64(0,0)  < lefttime ) then
			self._name =	PAGetStringParam2( Defines.StringSheet_GAME, "GAME_MESSAGE_HOUSE_HOD_NAME", "nickName", 
			ToClient_getBuildingOwnerName( buildingInfoSS ), "houseName", ToClient_getBuildTypeName( buildingInfoSS ) ) .. PAGetStringParam1( Defines.StringSheet_GAME, "LUA_CHARACTERNAMETAG_HOUSEHOLDNAME", "lefttimeText", lefttimeText ) -- ( <PAColor0xFFffe157>철거까지 남은 시간 : <PAColor0xFFff8787>" .. lefttimeText .. " <PAOldColor>)"
		else
			self._name =	PAGetStringParam2( Defines.StringSheet_GAME, "GAME_MESSAGE_HOUSE_HOD_NAME", "nickName", 
			ToClient_getBuildingOwnerName( buildingInfoSS ), "houseName", ToClient_getBuildTypeName( buildingInfoSS ) )
		end
					
	else
		self._name =	PAGetStringParam2( Defines.StringSheet_GAME, "GAME_MESSAGE_HOUSE_HOD_NAME", "nickName", 
	ToClient_getBuildingOwnerName( buildingInfoSS ), "houseName", ToClient_getBuildTypeName( buildingInfoSS ) )
	end
	

	self._icon 				= ""	-- 기능 추가 필요
	self._position			= ToClient_getBuildingPosition(buildingInfoSS)
	
	self._count_Total 		= 0
	self._count_Current 	= 0
	self._count_onGoing 	= 0
	
	self._subWork_Data		= {}
	
	local workingCout			= ToClient_getBuildingWorkingList( buildingInfoSS )
	
	local workingList = {}
	for idx = 1, workingCout do
		local worker		= ToClient_getBuildingWorkingWorkerByIndex( buildingInfoSS, idx - 1 ).workerNo
		local workerNo 		= worker:get_s64()
		local subWorkIndex 	= ToClient_getBuildingWorkingIndex(workerNo) + 1
		
		if nil == workingList[subWorkIndex] then
			workingList[subWorkIndex] = {}
		end
		local _index = #workingList[subWorkIndex] + 1
		workingList[subWorkIndex][_index] = worker	
	end	
	
	for index = 1, workCount do
		
		local buildingStaticStatus 	= ToClient_getBuildingWorkableBuildingSourceUnitByIndex(buildingInfoSS ,index - 1)
		local workKey			= buildingStaticStatus:getItemEnchantKey();
		local workName 			= "" -- 교체 필요!
		
		if index == 1 then
			self._workVolum		= math.ceil( buildingStaticStatus:getBuildTime() / 1000 )
		end
		
		local itemStatic 		= buildingStaticStatus:getItemStaticStatus();
		local gradeType			= 0 -- 추후 변경
		local key_Resource 		= itemStatic._key
		local icon_Resource		= "icon/" .. getItemIconPath(itemStatic)	
		local name_Resource		= getItemName(itemStatic)
		
		workName = name_Resource -- 추후 삭제!!		
		
		local count_Total 		= buildingStaticStatus._needBuildProgressPoint
		local count_Current 	= ToClient_getWorkableCurrentBuildingPoint(buildingInfoSS, index - 1)
			
		local workerList		= {}
		local count_onGoing 	= 0
		if nil ~= workingList[index] then
			workerList = workingList[index]
			count_onGoing = #workingList[index]
		end		
		
		local haveCount 		= 0
		if ( 0 ~= affiliatedTownKey ) then
			haveCount = Int64toInt32( warehouse_getItemCount( affiliatedTownKey , key_Resource ) )
		end

		self._subWork_Data[index] = 
		{
			_workKey		= workKey,		
			_workName		= workName,
				
			_resourceKey	= key_Resource,
			_resourceIcon	= icon_Resource,
			_resourceName	= name_Resource,
			
			_workerList		= workerList,
			
			_totalCount		= count_Total,
			_currentCount	= count_Current,
			_onGoingCount	= count_onGoing,
			
			_haveCount		= haveCount,			
			_gradeType		= gradeType,			
		}			
		
		self._count_Total 		= self._count_Total 	+ count_Total
		self._count_Current 	= self._count_Current 	+ count_Current
		self._count_onGoing 	= self._count_onGoing 	+ count_onGoing
	end
	
	SubWork_List:Init()
end

function Building_Info:_update()
	
	local _icon 				= self._icon
	local _name 				= self._name
	local _count_Total 			= self._count_Total
	local _count_Current 		= self._count_Current
	local _count_onGoing 		= self._count_onGoing
	
	local _count 				= tostring(_count_Current) .. "/" .. tostring(_count_Total)
	local _progress_OnGoing		= math.floor( (_count_onGoing + _count_Current) / _count_Total * 100 )
	local _progress_Complete	= math.floor( _count_Current / _count_Total * 100 )
	
	-- defalut_Control._building_Info._Icon					:ChangeTextureInfoName(_icon)
	defalut_Control._building_Info._Name					:SetText(_name)
	defalut_Control._building_Info._Current_Count         	:SetText(_count)	
	defalut_Control._building_Info._Progress_OnGoing      	:SetProgressRate(_progress_OnGoing)
	defalut_Control._building_Info._Progress_Complete     	:SetProgressRate(_progress_Complete)	
end

-----------------------------------------------------
-- 작업 목록(SubWork List) 관련 함수
-----------------------------------------------------

SubWork_List =
{
	_rowMax 				= defalut_Control._subWork_List._Template._rowMax,	
			
	_contentRow				= nil,	
	_offsetIndex 			= nil,
	_offset_Max 			= nil,
		
	_selected_SubWork		= nil,
	_selected_Index			= nil,
	_over_Index				= nil,
}

function SubWork_List:Init()

	self._contentRow		= #Building_Info._subWork_Data
	self._offsetIndex		= 0
	self._offset_Max		= self._contentRow - self._rowMax
	if self._offset_Max < 0 then
		self._offset_Max = 0
	end
	
	UIScroll.SetButtonSize( defalut_Control._subWork_List._Scroll, self._rowMax, self._contentRow )
end

function SubWork_List:_updateSlot(isRefresh)
	
	local _data 	= Building_Info._subWork_Data
	local _control 	= defalut_Control._subWork_List
	
	for idx = 1, self._rowMax do
		local _idx = self._offsetIndex + idx
		
		if nil == _data[_idx] then
			_control._Button[idx]				:SetShow(false)			
			_control._Progress_OnGoing[idx]		:SetShow(false)
			_control._Progress_Complete[idx]	:SetShow(false)
			_control._CountText_1[idx]			:SetShow(false)
			_control._CountText_2[idx]			:SetShow(false)
			_control._Ani_OnGoing[idx]			:SetShow(false)
		else
			
			local _workName 		= _data[_idx]._workName
			local _totalCount		= _data[_idx]._totalCount
			local _currentCount		= _data[_idx]._currentCount
			local _onGoingCount		= _data[_idx]._onGoingCount
			
			_control._Button[idx]:SetText(_workName)
			_control._Button[idx]:SetShow(true)
						
			if self._selected_Index == _idx then
				_control._Button[idx]:SetCheck(true)
			else
				_control._Button[idx]:SetCheck(false)
			end
			
			if _onGoingCount > 0 then
				_control._Ani_OnGoing[idx]		:SetShow(true)
			else
				_control._Ani_OnGoing[idx]		:SetShow(false)
			end	
			

			local progressRate_OnGoing	= math.floor((( _onGoingCount + _currentCount) / _totalCount) * 100)
			local progressRate_Complete	= math.floor(( _currentCount / _totalCount) * 100)
			
			if _totalCount == _currentCount then
				_control._CountText_2[idx]			:SetText(PAGetString( Defines.StringSheet_GAME, "LUA_HOUSEWORKLIST_LARGECRAFT_SUBWORK_FINISHED" ))
				_control._CountText_2[idx]			:SetShow(true)	
				
				_control._CountText_1[idx]			:SetShow(false)
			else
				_control._CountText_1[idx]			:SetText(tostring(_currentCount) .. "/" .. tostring(_totalCount))
				_control._CountText_1[idx]			:SetShow(true)
				
				_control._CountText_2[idx]			:SetShow(false)				
			end
				
			_control._Progress_OnGoing[idx]		:SetProgressRate(progressRate_OnGoing)
			_control._Progress_Complete[idx]	:SetProgressRate(progressRate_Complete)
	
			_control._Progress_OnGoing[idx]		:SetShow(true)
			_control._Progress_Complete[idx]	:SetShow(true)
			
			if _onGoingCount > 0 and ( self._selected_Index == _idx or self._over_Index == _idx ) then					
				-- _control._Progress_OnGoing[idx]	:SetShow(true)
				_control._CountText_1[idx]		:SetText("(+" .. tostring(_onGoingCount) .. ")  " .. tostring(_currentCount) .. "/" .. tostring(_totalCount))
			end

		end
	end
	
	-- HandleOn_Building_SubWork_List_Refresh()
end

function Building_Work_List_Select(index)
	if Panel_Window_Exchange_Number:IsShow() then
		Panel_NumberPad_Show( false, Defines.s64_const.s64_0, 0, nil)
	end
	local subWorkIndex	= SubWork_List._offsetIndex + index
	local _data 		= Building_Info._subWork_Data[subWorkIndex]
	if nil == _data then
		return
	end
	BuildingWork_Progress_List_SetWorkingCount( 1 )
	defalut_Control._subWork_Estimated._Time_Count:SetShow( true )
	defalut_Control._subWork_Estimated._Time_Count:SetText( PAGetStringParam1( Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_WORKMANAGER_BUILDING_DEFAULT", "getWorkingCount", BuildingWork_Progress_List_GetWorkingCount() ) ) -- "(" .. BuildingWork_Progress_List_GetWorkingCount() .. "회)" )
	SubWork_List._selected_SubWork				= _data._workKey
	SubWork_List._selected_Index				= subWorkIndex
	SubWork_List:_updateSlot()
	BuildingWork_Info_Update()
	BuildingWork_Estimated_Update()
end

function HandleOn_Building_SubWork_List(index)
	SubWork_List._over_Index			= SubWork_List._offsetIndex + index
	if SubWork_List._selected_Index ~= SubWork_List._over_Index then
		local data = Building_Info._subWork_Data[SubWork_List._over_Index]
		if data ~= nil then
			local _totalCount		= data._totalCount
			local _currentCount		= data._currentCount
			local _onGoingCount		= data._onGoingCount
			if _onGoingCount > 0 then					
				-- defalut_Control._subWork_List._Progress_OnGoing[index]	:SetShow(true)
				defalut_Control._subWork_List._CountText_1[index]		:SetText("(+" .. tostring(_onGoingCount) .. ")  " .. tostring(_currentCount) .. "/" .. tostring(_totalCount))
			end
		end
		BuildingWork_Info_Update(true)
		BuildingWork_Estimated_Update(true)
	end
end

function HandleOut_Building_SubWork_List()
	SubWork_List._over_Index			= nil
	SubWork_List:_updateSlot()
	BuildingWork_Info_Update()
	BuildingWork_Estimated_Update()
end

function HandleOn_Building_SubWork_List_Refresh()
	if nil ~= SubWork_List._over_Index then
		if defalut_Control._subWork_List._Button[SubWork_List._over_Index]:GetShow() then
			HandleOn_Building_SubWork_List(SubWork_List._over_Index)
		else
			HandleOut_Building_SubWork_List()
		end
	end
end

-----------------------------------------------------
-- 일꾼 목록(Worker List) 관련 함수
-----------------------------------------------------

local Worker_List =
{
	_data_Table 			= {},
			
	_rowMax 				= defalut_Control._worker_List._Template._rowMax,	
			
	_contentRow				= nil,	
	_offsetIndex 			= nil,
	_offset_Max 			= nil,
		
	_selected_Worker		= nil,
	_selected_WorkerKey		= nil,
	_selected_Index			= nil,
	_over_Index				= nil,
}

-- 지역 별로 일꾼을 정렬해주자.
local workingTime = {}
local homeWayKey = {}
local sortDistanceValue = {}
local Worker_SortByRegionInfo = function()

	local	buildingInfoSS	= ToClient_getBuildingInfo( buildingActorKey ); 

	if( nil == buildingInfoSS ) then
		return;
	end

	local productCategory		= 6
	local workableKey			= Building_Info._subWork_Data[1]._workKey
	local sortMethod 			= 0
	local plantKey 				= ToClient_getBuildingPlantKey( buildingInfoSS )
	local buildingTerritoryKey	= plantKey:get()
	local waitingWorkerCount 	= ToClient_getBuildingWaitWorkerListCount( buildingInfoSS, sortMethod )
	
	if ( 0 == waitingWorkerCount ) then
		return
	end
	
	local possibleWorkerIndex = 0
	for index = 1, waitingWorkerCount do
		local npcWaitingWorker = ToClient_getBuildingWaitWorkerByIndex( buildingInfoSS, index - 1 )
		local workerNoRaw		= npcWaitingWorker:getWorkerNo():get_s64()
		local workerWrapperLua	= getWorkerWrapper( workerNoRaw, false )

		if( true == ToClient_isWaitWorker( npcWaitingWorker ) and ( false == workerWrapperLua:getIsAuctionInsert() ) ) then
			possibleWorkerIndex = possibleWorkerIndex + 1
			local workVolume	= Building_Info._workVolum
			local distance		= ToClient_getCalculateMoveDistance( Worker_List._data_Table[possibleWorkerIndex]._workerNo, Building_Info._position) / 100
			local workSpeed		= Worker_List._data_Table[possibleWorkerIndex]._workSpeed
			local moveSpeed		= Worker_List._data_Table[possibleWorkerIndex]._moveSpeed
			local luck			= Worker_List._data_Table[possibleWorkerIndex]._luck
			local workBaseTime 	= ToClient_getNpcWorkingBaseTime() / 1000
			local totalWorkTime	= math.ceil(workVolume/workSpeed) * workBaseTime + (distance/moveSpeed) * 2

			workingTime[possibleWorkerIndex]		= Int64toInt32(totalWorkTime)
			homeWayKey[possibleWorkerIndex]			= Worker_List._data_Table[possibleWorkerIndex]._homeWaypoint
			sortDistanceValue[possibleWorkerIndex]	= distance
		end
	end
	local possibleWorkerCount = possibleWorkerIndex
	
	local temp = nil
	local workerDataSwap = function( index, sortCount )
		if ( index ~= sortCount ) and ( Worker_List._data_Table[index]._homeWaypoint ~= Worker_List._data_Table[sortCount]._homeWaypoint ) then
			temp = Worker_List._data_Table[index]
			Worker_List._data_Table[index] = Worker_List._data_Table[sortCount]
			Worker_List._data_Table[sortCount] = temp
			temp = sortDistanceValue[index]
			sortDistanceValue[index] = sortDistanceValue[sortCount]
			sortDistanceValue[sortCount] = temp
		end
	end

	-- 우선 작업시간 별로 정렬
	for ii = 1, possibleWorkerCount do
		local temp = nil
		for i = possibleWorkerCount, 1, -1 do
			if 1 < i and workingTime[i] < workingTime[i-1] then
				temp = Worker_List._data_Table[i]
				Worker_List._data_Table[i] = Worker_List._data_Table[i-1]
				Worker_List._data_Table[i-1] = temp
				temp = workingTime[i]
				workingTime[i] = workingTime[i-1]
				workingTime[i-1] = temp
				temp = sortDistanceValue[i]
				sortDistanceValue[i] = sortDistanceValue[i-1]
				sortDistanceValue[i-1] = temp
			end
		end
		if nil == temp then
			break
		end
	end
	
	-- 이후 노드키 별로 정렬(같은 영지 내의 일꾼부터 표시)
	local territory = {}
	if 0 < buildingTerritoryKey and 300 >= buildingTerritoryKey then			-- 발레노스 영지
		territory[0] = true
		territory[1] = false
		territory[2] = false
		territory[3] = false
	elseif 301 <= buildingTerritoryKey and 600 >= buildingTerritoryKey then		-- 세렌디아 영지
		territory[0] = false
		territory[1] = true
		territory[2] = false
		territory[3] = false
	elseif 601 <= buildingTerritoryKey and 1000 >= buildingTerritoryKey then	-- 칼페온 영지
		territory[0] = false
		territory[1] = false
		territory[2] = true
		territory[3] = false
	elseif 1101 <= buildingTerritoryKey then
		territory[0] = false
		territory[1] = false
		territory[2] = false
		territory[3] = true
		
	end
	
	-- 작업시킬 거점에 속해 있는 일꾼부터 정렬 : 성채는 거점 생산이 아니라 필요 없다!
	local _sortCount = 0
	-- for ii = _sortCount + 1, possibleWorkerCount do
		-- if ( homeWayKey[ii] == buildingTerritoryKey ) then
			-- _sortCount = _sortCount + 1
			-- if ( ii ~= _sortCount ) then
				-- workerDataSwap( ii, _sortCount )
			-- end
		-- end
	-- end
	
	local sortByRegion = function( territoryKey )
		local sortTerritoryCount = 0
		local startValue = _sortCount + 1

		if ( possibleWorkerCount < startValue ) then
			return
		end
		if ( 0 == territoryKey ) then
			for jj = startValue, possibleWorkerCount do
				if 0 < Worker_List._data_Table[jj]._homeWaypoint and 300 >= Worker_List._data_Table[jj]._homeWaypoint then
					if startValue ~= jj then
						workerDataSwap( jj, startValue + sortTerritoryCount )
					end
					_sortCount = _sortCount + 1
					sortTerritoryCount = sortTerritoryCount + 1
				end
			end

		elseif ( 1 == territoryKey ) then
			for jj = startValue, possibleWorkerCount do
				if 301 <= Worker_List._data_Table[jj]._homeWaypoint and 600 >= Worker_List._data_Table[jj]._homeWaypoint then
					if startValue ~= jj then
						workerDataSwap( jj, startValue + sortTerritoryCount )
					end
					_sortCount = _sortCount + 1
					sortTerritoryCount = sortTerritoryCount + 1
				end
			end

		elseif ( 2 == territoryKey ) then
			for jj = startValue, possibleWorkerCount do
				if 601 <= Worker_List._data_Table[jj]._homeWaypoint and 1000 >= Worker_List._data_Table[jj]._homeWaypoint then
					if startValue ~= jj then
						workerDataSwap( jj, startValue + sortTerritoryCount )
					end
					_sortCount = _sortCount + 1
					sortTerritoryCount = sortTerritoryCount + 1
				end
			end
		
		elseif ( 3 == territoryKey ) then
			for jj = startValue, possibleWorkerCount do
				if 1101 <= Worker_List._data_Table[jj]._homeWaypoint then
					if startValue ~= jj then
						workerDataSwap( jj, startValue + sortTerritoryCount )
					end
					_sortCount = _sortCount + 1
					sortTerritoryCount = sortTerritoryCount + 1
				end
			end

		end
		
		-- 영지별로 분류했으면, 다시 거리로 정렬 / 거리가 같을 경우 이미 작업시간으로 분류돼 있다
		if ( 1 < sortTerritoryCount ) then
			for ii = 1, sortTerritoryCount - 1 do
				for jj = startValue + sortTerritoryCount - 1, startValue + 1, -1 do
					if ( sortDistanceValue[jj] < sortDistanceValue[jj-1] ) then
						workerDataSwap( jj, jj-1 )
					end
				end
			end
		end
	end
	
	if ( possibleWorkerCount ~= _sortCount ) then
		-- 발레노스 영지 작업관리
		if true == territory[0] then
			sortByRegion(0)
			sortByRegion(1)
			sortByRegion(2)
			sortByRegion(3)

		-- 세렌디아 영지 작업관리
		elseif true == territory[1] then
			sortByRegion(1)
			sortByRegion(0)
			sortByRegion(2)
			sortByRegion(3)

		-- 칼페온 영지 작업관리
		elseif true == territory[2] then
			sortByRegion(2)
			sortByRegion(1)
			sortByRegion(0)
			sortByRegion(3)
		
		-- 메디아 영지 작업관리
			sortByRegion(3)
			sortByRegion(1)
			sortByRegion(0)
			sortByRegion(2)
		end
	end
			
end

function Worker_List:_setData()

	local	buildingInfoSS	= ToClient_getBuildingInfo( buildingActorKey ); 

	if( nil == buildingInfoSS ) then
		return;
	end
	
	local productCategory				= 6
	local workableKey					= Building_Info._subWork_Data[1]._workKey
	local sortMethod 					= 0
		
	local plantKey 				= ToClient_getBuildingPlantKey( buildingInfoSS )
	local waitingWorkerCount 	= ToClient_getBuildingWaitWorkerListCount( buildingInfoSS, sortMethod )

	if waitingWorkerCount <= 0 then
		defalut_Control._subWork_Estimated._No_Resource_Work:SetText( PAGetString(Defines.StringSheet_RESOURCE, "PANEL_RENTHOUSE_WORKMANAGER_WORKERLIST_NOWORKER") )
	else
		defalut_Control._subWork_Estimated._No_Resource_Work:SetText( PAGetString(Defines.StringSheet_RESOURCE, "PANEL_RENTHOUSE_WORKMANAGER_BTN_DISABLEWORK") )
	end
		
	local _Idx = 0
	self._data_Table = {}
	for Index = 1, waitingWorkerCount do
		local npcWaitingWorker	= ToClient_getBuildingWaitWorkerByIndex( buildingInfoSS, Index - 1 )
		local workerNoRaw		= npcWaitingWorker:getWorkerNo():get_s64()
		local workerWrapperLua	= getWorkerWrapper( workerNoRaw, false )

		if( true == ToClient_isWaitWorker( npcWaitingWorker ) and ( false == workerWrapperLua:getIsAuctionInsert() ) ) then
			_Idx = _Idx + 1
			if nil == self._data_Table[_Idx]	then
				self._data_Table[_Idx] = {}
			end

			local checkData = npcWaitingWorker:getStaticSkillCheckData()
			checkData:set(CppEnums.NpcWorkingType.eNpcWorkingType_PlantBuliding, houseUseType, 0)
			checkData._diceCheckForceSuccess = true
	
			local firstWorkerNo			= npcWaitingWorker:getWorkerNo();		
			local workerNoChar 			= firstWorkerNo:get_s64()		
			local npcWaitingWorkerSS 	= npcWaitingWorker:getWorkerStaticStatus();
			local workerNo 				= WorkerNo( workerNoChar )
			local houseUseType			= CppEnums.eHouseUseType.Count
			local workSpeed				= npcWaitingWorker:getWorkEfficienceWithSkill(checkData, productCategory)	-- 건설일때
			local moveSpeed				= npcWaitingWorker:getMoveSpeedWithSkill(checkData) / 100.0
			local maxPoint 				= npcWaitingWorkerSS._actionPoint
			local currentPoint 			= npcWaitingWorker:getActionPoint()
			local workerRegionWrapper	= ToClient_getRegionInfoWrapper( npcWaitingWorker )
			local name					= "Lv."..npcWaitingWorker:getLevel() .. " " .. ToClient_getWorkerName(npcWaitingWorkerSS) .. "(<PAColor0xff868686>" .. workerRegionWrapper:getAreaName() .. "<PAOldColor>)"
			local homeWaypoint			= npcWaitingWorker:getHomeWaypoint()
			local workerGrade			= npcWaitingWorkerSS:getCharacterStaticStatus()._gradeType:get()	-- 일꾼 등급

			self._data_Table[_Idx] =
			{
				_workerNo		= workerNo,
				_workerNo_s64	= workerNoChar,
				_workerNoChar	= Int64toInt32(workerNoChar),
				_name			= name,
				_workSpeed 		= workSpeed / 1000000,
				_moveSpeed 		= moveSpeed,
				_maxPoint 		= maxPoint,
				_currentPoint 	= currentPoint,
				_homeWaypoint	= homeWaypoint,
				_workerGrade	= workerGrade,
			}			
		end
	end
		
	local _offset_Max = _Idx - self._rowMax
	if _offset_Max < 0 then
		_offset_Max = 0
	end
	
	self._offset_Max 	= _offset_Max
	if nil == self._offsetIndex then
		self._offsetIndex 	= 0
	end
	self._contentRow	= _Idx	
	
	UIScroll.SetButtonSize( defalut_Control._worker_List._Scroll, self._rowMax, self._contentRow ) -- 스크롤바 버튼의 크기를 조정한다.
	Worker_SortByRegionInfo()
end

function Worker_List:_updateSlot()
	local isSelectedWorker = false
	local rowIndex = self._offsetIndex
	for index = 1, self._rowMax do
		local _dataIndex 	= rowIndex + index
		local data 			= self._data_Table[_dataIndex]
		if nil ~= data then		
			local name			= data._name
			local actionPoint	= tostring(data._currentPoint) .."/" .. tostring(data._maxPoint)
			local preogressRate = math.floor( (data._currentPoint / data._maxPoint) * 100)
			local workerGrade	= data._workerGrade

			defalut_Control._worker_List._Button[index]		:SetFontColor( ConvertFromGradeToColor(workerGrade) )
			
			defalut_Control._worker_List._Button[index]		:SetTextMode( CppEnums.TextMode.eTextMode_LimitText ) -- 일꾼 이름 자르기
			
			defalut_Control._worker_List._Button[index]		:SetText(name)
			defalut_Control._worker_List._ActionPoint[index]:SetText(actionPoint)
			defalut_Control._worker_List._Progress[index]	:SetProgressRate(preogressRate)
			
			defalut_Control._worker_List._Button[index]		:SetShow(true)
			defalut_Control._worker_List._Progress[index]	:SetShow(true)
			
			if self._selected_WorkerKey == data._workerNoChar then 
				defalut_Control._worker_List._Button[index]:SetCheck(true)
				defalut_Control._worker_List._ActionPoint[index]:SetShow(true)
			else
				defalut_Control._worker_List._Button[index]:SetCheck(false)
				defalut_Control._worker_List._ActionPoint[index]:SetShow(false)
			end
		else
			defalut_Control._worker_List._Button[index]			:SetShow(false)
			defalut_Control._worker_List._ActionPoint[index]   	:SetShow(false)
			defalut_Control._worker_List._Progress[index]      	:SetShow(false)
		end
	end

	--local maxWorker = self._offset_Max + self._offset_Max
	for index = 1, #self._data_Table do
		local data = self._data_Table[index]
		if( nil ~= data ) then
			if( self._selected_WorkerKey ==	data._workerNoChar ) then
				isSelectedWorker = true;
			end
		end
	end
	
	if false == isSelectedWorker then
		self._selected_Worker			= nil
		self._selected_WorkerKey		= nil
		self._selected_Index			= nil
	end
	
	defalut_Control._worker_List._Scroll:SetControlPos( self._offsetIndex / self._offset_Max) -- 스크롤바 버튼의 위치를 조정한다.
	HandleOn_Building_Worker_List_Refresh()
end

function Building_Worker_List_Select(index)	
	if Panel_Window_Exchange_Number:IsShow() then
		Panel_NumberPad_Show( false, Defines.s64_const.s64_0, 0, nil)
	end
	local selectedIndex						= Worker_List._offsetIndex + index
	if nil ~= Worker_List._data_Table[selectedIndex] then
		Worker_List._selected_Worker			= Worker_List._data_Table[selectedIndex]._workerNo
		Worker_List._selected_WorkerKey			= Worker_List._data_Table[selectedIndex]._workerNoChar
		Worker_List._selected_Index				= selectedIndex
		affiliatedTownKey	= Worker_List._data_Table[selectedIndex]._homeWaypoint
		warehouse_requestInfo(affiliatedTownKey) -- 창고 Data를 가져온다!
		defalut_Control._worker_List._No_Worker:SetShow(false)
	else
		defalut_Control._worker_List._No_Worker:SetShow(true)
	end
	BuildingWork_Progress_List_SetWorkingCount( 1 )
	if 0 < BuildingWork_Progress_List_GetWorkingCount() then
		defalut_Control._subWork_Estimated._Time_Count		:SetShow(true)
	else
		defalut_Control._subWork_Estimated._Time_Count		:SetShow(false)
	end
	defalut_Control._subWork_Estimated._Time_Count:SetText( PAGetStringParam1( Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_WORKMANAGER_BUILDING_DEFAULT", "getWorkingCount", BuildingWork_Progress_List_GetWorkingCount() ) ) -- "(" .. BuildingWork_Progress_List_GetWorkingCount() .. "회)" )
	Worker_List:_updateSlot()
	BuildingWork_Estimated_Update()
end

function HandleOn_Building_Worker_List(index)
	Worker_List._over_Index		= index
	defalut_Control._worker_List._ActionPoint[index]:SetShow(true)
	BuildingWork_Estimated_Update(false)

	local self = Worker_List
	local workerIndex = self._offsetIndex + index

	local npcWaitingWorker = ToClient_getNpcWorkerByWorkerNo( Worker_List._data_Table[workerIndex]._workerNo_s64 )
	if nil ~= npcWaitingWorker then
		local uiBase = defalut_Control._worker_List._Button[index]
		
		FGlobal_ShowWorkerTooltipByWorkerNoRaw( Worker_List._data_Table[workerIndex]._workerNo_s64, uiBase )
		-- FGlobal_ShowWorkerTooltip( npcWaitingWorker:get(), uiBase, true )
	end
end

function HandleOut_Building_Worker_List()
	Worker_List._over_Index		= nil
	Worker_List:_updateSlot()
	BuildingWork_Estimated_Update()

	FGlobal_HideWorkerTooltip()
end

function HandleOn_Building_Worker_List_Refresh()
	if nil ~= Worker_List._over_Index then
		HandleOn_Building_Worker_List(Worker_List._over_Index)
	end
end
-----------------------------------------------------
-- 제작 상세 정보/제작 예상 시간 Update 관련 함수
-----------------------------------------------------
local BuildingWork_Progress_List =
{
	_workerList				= nil,
	_onGoingCount			= nil,
	_workingCount			= 0,
	_rowMax 				= defalut_Control._subWork_Info._Template._rowMax,	
			
	_contentRow				= nil,	
	_offsetIndex 			= nil,
	_offset_Max 			= nil,
	
	_last_offset 			= nil,
}

function BuildingWork_Progress_List_SetWorkingCount( count )
	if ( nil == count ) or ( count < 1 ) then
		count = 1
	end
	BuildingWork_Progress_List._workingCount = 1
end

function BuildingWork_Progress_List_GetWorkingCount()
	return BuildingWork_Progress_List._workingCount
end


function BuildingWork_Progress_List:_updateSlot()
	BuildingWork_Progress_List_UpdateSlot()
end

function BuildingWork_Progress_List_UpdateSlot(isRefresh, isOver)
	
	if 0 == BuildingWork_Progress_List._onGoingCount and true ~= isRefresh then
		return
	end

	if true == isRefresh then
		local subWorkIndex 					= SubWork_List._selected_Index
		if isOver then
			subWorkIndex 					= SubWork_List._over_Index
		end

		BuildingWork_Progress_List._workerList	= Building_Info._subWork_Data[subWorkIndex]._workerList
		BuildingWork_Progress_List._onGoingCount	= #BuildingWork_Progress_List._workerList
				
		if 0 == BuildingWork_Progress_List._onGoingCount then
			defalut_Control._subWork_Info._OnGoing_Guide :SetShow(true)
		else
			defalut_Control._subWork_Info._OnGoing_Guide :SetShow(false)
		end
		
		local _offset_Max = BuildingWork_Progress_List._onGoingCount - BuildingWork_Progress_List._rowMax 
		if _offset_Max < 0 then
			_offset_Max = 0
		end
		BuildingWork_Progress_List._offset_Max 	= _offset_Max
		BuildingWork_Progress_List._contentRow 	= BuildingWork_Progress_List._onGoingCount
		BuildingWork_Progress_List._offsetIndex 	= 0
		
		UIScroll.SetButtonSize( defalut_Control._subWork_Info._OnGoing_Scroll, BuildingWork_Progress_List._rowMax, BuildingWork_Progress_List._contentRow )
	end
	
	local isScrolled = (BuildingWork_Progress_List._last_offset ~= BuildingWork_Progress_List._offsetIndex)
	
	if true == isRefresh or isScrolled then
		FGlobal_Clear_Control(defalut_Control._subWork_Info._OnGoing_Time)
		FGlobal_Clear_Control(defalut_Control._subWork_Info._OnGoing_Progress_BG)
		FGlobal_Clear_Control(defalut_Control._subWork_Info._OnGoing_Progress)
		FGlobal_Clear_Control(defalut_Control._subWork_Info._OnGoing_Cancel)
		
		BuildingWork_Progress_List._last_offset = BuildingWork_Progress_List._offsetIndex
	end
	
	for idx = 1, BuildingWork_Progress_List._rowMax do
		local Index 		= BuildingWork_Progress_List._offsetIndex + idx
		local worker		= BuildingWork_Progress_List._workerList[Index]
		if nil == worker then
			break
		end
		local workerNo		= worker:get_s64()
		local progressRate 	= ToClient_getWorkingProgress( workerNo ) * 100000	
		local remainTime 	= Util.Time.timeFormatting( ToClient_getLeftWorkingTime( workerNo ) )

		if 0 < ToClient_getNpcWorkerWorkingCount( workerNo ) then
			defalut_Control._subWork_Info._OnGoing_Cancel[idx]:SetText( PAGetStringParam1( Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_WORKMANAGER_BUILDING_ONGOING", "workerNo", ToClient_getNpcWorkerWorkingCount( workerNo ) ) ) -- "(" .. ToClient_getNpcWorkerWorkingCount( workerNo ) .. "회 남음) ")
		else
			defalut_Control._subWork_Info._OnGoing_Cancel[idx]:SetText( "" )
		end

				defalut_Control._subWork_Info._OnGoing_Time[idx]   		:SetText(remainTime)
		defalut_Control._subWork_Info._OnGoing_Progress[idx]  	:SetProgressRate(progressRate)
		
		if true == isRefresh or isScrolled then
			defalut_Control._subWork_Info._OnGoing_Time[idx]   		:SetShow(true)
			defalut_Control._subWork_Info._OnGoing_Progress_BG[idx]	:SetShow(true)
			defalut_Control._subWork_Info._OnGoing_Progress[idx]  	:SetShow(true)
			defalut_Control._subWork_Info._OnGoing_Cancel[idx]  	:SetShow(true)
		end
	end	
	
	if 0 ~= BuildingWork_Progress_List._offset_Max then
		defalut_Control._subWork_Info._OnGoing_Scroll:SetControlPos( BuildingWork_Progress_List._offsetIndex / BuildingWork_Progress_List._offset_Max)
	end
end

function BuildingWork_Info_Update(isWorkOver)
	local subWorkIndex = SubWork_List._selected_Index
	
	if isWorkOver then
		subWorkIndex = SubWork_List._over_Index 
	end
	
	local _data 		= Building_Info._subWork_Data[subWorkIndex]
	local icon 			= _data._resourceIcon
	local key			= _data._resourceKey
	local name			= _data._resourceName
	local haveCount		= _data._haveCount
	
	if haveCount < 1 then
		haveCount = "<PAColor0xFFDB2B2B>" .. haveCount .. "/1<PAOldColor>"
	else
		haveCount = tostring(haveCount) .. "/1"
	end	
	
	local gradeType = _data._gradeType

	if (0 < gradeType) and (gradeType <= #UI.itemSlotConfig.borderTexture) then
		defalut_Control._subWork_Info._Resource_Icon_Border:ChangeTextureInfoName( UI.itemSlotConfig.borderTexture[gradeType].texture )			
		local x1, y1, x2, y2 = setTextureUV_Func( defalut_Control._subWork_Info._Resource_Icon_Border, UI.itemSlotConfig.borderTexture[gradeType].x1, UI.itemSlotConfig.borderTexture[gradeType].y1, UI.itemSlotConfig.borderTexture[gradeType].x2, UI.itemSlotConfig.borderTexture[gradeType].y2 )
		defalut_Control._subWork_Info._Resource_Icon_Border:getBaseTexture():setUV(  x1, y1, x2, y2  )
		defalut_Control._subWork_Info._Resource_Icon_Border:setRenderTexture(defalut_Control._subWork_Info._Resource_Icon_Border:getBaseTexture())	
		defalut_Control._subWork_Info._Resource_Icon_Border:SetShow(true)
	else
		defalut_Control._subWork_Info._Resource_Icon_Border:SetShow(false)
	end
	
	defalut_Control._subWork_Info._Resource_Icon		:ChangeTextureInfoName(icon)
	defalut_Control._subWork_Info._Resource_Name		:SetText(name)
	defalut_Control._subWork_Info._Resource_Count		:SetText(haveCount)
	-- _PA_LOG("LUA", tostring(haveCount) )
	
	BuildingWork_Progress_List_UpdateSlot(true, isWorkOver)
end

function BuildingWork_Estimated_Update(isWorkOver)

	local subWorkIndex 	= SubWork_List._selected_Index
	if true == isWorkOver then
		subWorkIndex = SubWork_List._over_Index
	end
	local _data 		= Building_Info._subWork_Data[subWorkIndex]
	
	local workerIndex 	= Worker_List._selected_Index
	if false == isWorkOver then
		workerIndex = Worker_List._over_Index
	end
	
	local workVolume 		= Building_Info._workVolum
	defalut_Control._subWork_Estimated._Work_Volume_Value		:SetText(": " .. string.format("%.2f", workVolume))

	local distance 		= 0
	local workSpeed     = 0
	local moveSpeed     = 0
	if nil ~= Worker_List._data_Table[workerIndex] then
		distance 		= ToClient_getCalculateMoveDistance( Worker_List._data_Table[workerIndex]._workerNo, Building_Info._position) / 100
		workSpeed		= Worker_List._data_Table[workerIndex]._workSpeed
		moveSpeed		= Worker_List._data_Table[workerIndex]._moveSpeed

		defalut_Control._subWork_Estimated._Move_Distance_Value		:SetText(": " .. string.format("%0.f", distance))
		defalut_Control._subWork_Estimated._Work_Speed_Value		:SetText(": " .. string.format("%2.f", workSpeed))
		defalut_Control._subWork_Estimated._Move_Speed_Value		:SetText(": " .. string.format("%2.f", moveSpeed))
	end
	defalut_Control._subWork_Estimated._Time_Value:SetShow( false )
	if nil ~= Worker_List._data_Table[workerIndex] then
		local workBaseTime 	= ToClient_getNpcWorkingBaseTime() / 1000
		local totalWorkTime	= math.ceil(workVolume/math.floor(workSpeed)) * workBaseTime + (distance/moveSpeed) * 2
		defalut_Control._subWork_Estimated._Time_Value				:SetShow( true )
		defalut_Control._subWork_Estimated._Time_Value				:SetText(Util.Time.timeFormatting(math.floor(totalWorkTime)))
	end	
		
	if _data._totalCount == _data._currentCount then
		defalut_Control._subWork_Estimated._Button_DoWork	:SetShow(false)
		defalut_Control._subWork_Estimated._chk_IgnoreWorkingCount:SetShow(false)
		defalut_Control._subWork_Estimated._Finished_Work	:SetShow(true)	
		defalut_Control._subWork_Estimated._No_Resource_Work:SetShow(false)
		defalut_Control._subWork_Estimated._Work_Count		:SetShow(false)
		defalut_Control._subWork_Estimated._Time_Count		:SetShow(true)
		defalut_Control._subWork_Estimated._Time_Count		:SetText( PAGetString(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_WORKMANAGER_BUILDING_COMPLETE") ) -- "(완료)" )
	elseif _data._haveCount < 1 then
		defalut_Control._subWork_Estimated._Button_DoWork	:SetShow(false)
		defalut_Control._subWork_Estimated._chk_IgnoreWorkingCount:SetShow(false)
		defalut_Control._subWork_Estimated._Finished_Work	:SetShow(false)	
		defalut_Control._subWork_Estimated._No_Resource_Work:SetShow(true)	
		defalut_Control._subWork_Estimated._Work_Count		:SetShow(false)
		defalut_Control._subWork_Estimated._Time_Count		:SetShow( false )
		-- defalut_Control._subWork_Estimated._Time_Count		:SetText( PAGetString(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_WORKMANAGER_BUILDING_ONCE") ) -- "(1회)" )
	else
		defalut_Control._subWork_Estimated._Button_DoWork	:SetShow(true)
		defalut_Control._subWork_Estimated._chk_IgnoreWorkingCount:SetShow(true)
		defalut_Control._subWork_Estimated._Finished_Work	:SetShow(false)	
		defalut_Control._subWork_Estimated._No_Resource_Work:SetShow(false)
		defalut_Control._subWork_Estimated._Work_Count		:SetShow(true)
		defalut_Control._subWork_Estimated._Time_Count		:SetShow(true)
		defalut_Control._subWork_Estimated._Time_Count		:SetText( PAGetString(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_WORKMANAGER_BUILDING_ONCE") ) -- "(1회)" )
	end
end

-----------------------------------------------------
-- Scroll 관련 함수
-----------------------------------------------------

local Scroll_UpDown = function(isUp, _target)
	if ( false == isUp ) then
		_target._offsetIndex = math.min(_target._offset_Max, _target._offsetIndex + 1)
	else
		_target._offsetIndex = math.max(0, _target._offsetIndex -1)
	end
	_target:_updateSlot()
	-- HouseWorkListSection_ShowTooltip_Reflesh()
end

function HandleScroll_Building_SubWork_List_UpDown(isUp)
	Scroll_UpDown(isUp, SubWork_List)
end

function HandleScroll_Building_Worker_List_UpDown(isUp)
	Scroll_UpDown(isUp, Worker_List)
end

function HandleScroll_Building_SubWork_Progress_List_UpDown(isUp)
	Scroll_UpDown(isUp, BuildingWork_Progress_List)
end

local ScrollOnClick = function(_target, _scroll)
	local _scroll_Button = _scroll:GetControlButton()
	local _scroll_Blank = _scroll:GetSizeY() - _scroll_Button:GetSizeY() 
	local _scroll_Percent = _scroll_Button:GetPosY() / _scroll_Blank
	_target._offsetIndex = math.floor(_scroll_Percent * _target._offset_Max)
	_target:_updateSlot()
end

function HandleScroll_Building_SubWork_List_OnClick()
	ScrollOnClick(SubWork_List, defalut_Control._subWork_List._Scroll)
end

function HandleScroll_Building_Worker_List_OnClick()
	ScrollOnClick(Worker_List, defalut_Control._worker_List._Scroll)
end

function HandleScroll_Building_SubWork_Progress_List_OnClick()
	ScrollOnClick(BuildingWork_Progress_List, defalut_Control._subWork_Info._OnGoing_Scroll)
end
-----------------------------------------------------
-- ToolTip 관련 함수
-----------------------------------------------------

function Item_Tooltip_Show_Building()
	local subWorkIndex	 	= SubWork_List._selected_Index

	local staticStatusKey = Building_Info._subWork_Data[subWorkIndex]._resourceKey
	local uiBase = defalut_Control._subWork_Info._Resource_Icon_BG

	if ( nil == staticStatusKey ) or ( nil == uiBase ) then
		return
	end
	
	local staticStatusWrapper = getItemEnchantStaticStatus( staticStatusKey )
	
	Panel_Tooltip_Item_Show(staticStatusWrapper, uiBase, true, false)
end

-----------------------------------------------------
-- Panel Open/Close 관련 함수
-----------------------------------------------------

function FGlobal_Building_WorkManager_Open(actorKey)

	local	buildingInfoSS	= ToClient_getBuildingInfo( actorKey ); 

	if( nil == buildingInfoSS ) then
		return;
	end
	Panel_Building_WorkManager:SetShow(true)
	
	Worker_List._selected_Worker		= nil
	Worker_List._selected_WorkerKey		= nil
	Worker_List._selected_Index			= nil
	Worker_List._offsetIndex			= nil
	Worker_List._over_Index				= nil

	FGlobal_Building_WorkManager_Refresh()

	defalut_Control._subWork_Estimated._chk_IgnoreWorkingCount:SetCheck( false )
	
	buildingActorKey		= actorKey;
	-- houseParam		= param
	Building_Info:_setData(true)
	Worker_List:_setData()	
		
	Building_Info:_update()
	SubWork_List:_updateSlot(true)
	Worker_List:_updateSlot()
	
	Building_Work_List_Select(1)
	SubWork_List:_updateSlot()
	Building_Worker_List_Select(1)
	Worker_List:_updateSlot()	
	
	defalut_Control._title:SetText(PAGetStringParam2( Defines.StringSheet_GAME, "GAME_MESSAGE_HOUSE_HOD_NAME", "nickName", 
	ToClient_getBuildingOwnerName( buildingInfoSS ), "houseName", ToClient_getBuildTypeName( buildingInfoSS ) ))	
end

function FGlobal_Building_WorkManager_Close()
	
--	Panel_Building_WorkManager:SetShow(false)
	FGlobal_WorldMapWindowEscape()
end

function FGlobal_Building_WorkManager_Reset_Pos()
	local PosX = ( getScreenSizeX() - Panel_Building_WorkManager:GetSizeX() ) / 2
	local PosY = ( getScreenSizeY() - Panel_Building_WorkManager:GetSizeY() ) / 2
	Panel_Building_WorkManager:SetPosX(PosX)
	Panel_Building_WorkManager:SetPosY(PosY)
end
-----------------------------------------------------
-- 작업 시작 Button 관련 함수
-----------------------------------------------------

function HandleClick_doWork_Building()
	local	buildingInfoSS	= ToClient_getBuildingInfo( buildingActorKey ); 

	if( nil == buildingInfoSS ) then
		return;
	end

	if workerManager_CheckWorkingOtherChannelAndMsg() then
		return
	end
	
	local workingCount		= BuildingWork_Progress_List._workingCount
	local selected_SubWork 	= SubWork_List._selected_SubWork
	local selected_Worker 	= Worker_List._selected_Worker
	local plantKey			= ToClient_getBuildingPlantKey( buildingInfoSS )
	local houseHoldNo		= ToClient_getBuildingHosueHoldNo( buildingInfoSS )
	
	if ( nil == selected_Worker ) then
		Proc_ShowMessage_Ack( PAGetString(Defines.StringSheet_GAME, "Lua_RentHouseNoWorkingByWorkerNotSelect") )
		return
	end

	local isIgnoreWokingCount = defalut_Control._subWork_Estimated._chk_IgnoreWorkingCount:IsCheck()

	if ( Building_Info._subWork_Data[SubWork_List._selected_Index]._totalCount <= Building_Info._subWork_Data[SubWork_List._selected_Index]._currentCount + Building_Info._subWork_Data[SubWork_List._selected_Index]._onGoingCount ) and false == isIgnoreWokingCount then
		Proc_ShowMessage_Ack( PAGetString(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_WORKMANAGER_BUILDING_ONGOINGCOUNT_ACK") ) -- "일이 완성되는 단계 입니다. 추가적으로 일꾼을 보낼 수 없습니다.")
		return
	end
	
	requestStartHouseholdBuildingToNpcWorker( selected_Worker, plantKey, houseHoldNo, selected_SubWork, workingCount, isIgnoreWokingCount ); 
	FGlobal_RedoWork( 3, nil, selected_Worker, plantKey, nil, selected_SubWork, workingCount, nil, houseHoldNo, affiliatedTownKey )
end

function HandleClick_doWork_IgnoreWorkingCount()	-- 진행중인 작업 수 무시
	if defalut_Control._subWork_Estimated._chk_IgnoreWorkingCount:IsCheck() then
		local	messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_BUILDING_IGNOREWORKINGCOUNT")	-- "현재 진행중인 작업을 포함해 완료까지 필요한 작업 수를 <PAColor0xFFF26A6A>초과하더라도, 이를 무시하고 작업<PAOldColor> 시킵니다.\n이 때, <PAColor0xFFF26A6A>소진된 재료는 반환되지 않습니다.<PAOldColor>"
		local	messageBoxData = { title = PAGetString ( Defines.StringSheet_GAME, "LUA_WARNING"), content = messageBoxMemo, functionApply = MessageBox_Empty_function, priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW}
		MessageBox.showMessageBox(messageBoxData)
	end
end

-----------------------------------------------------
-- 작업 횟수 Button 관련 함수
-----------------------------------------------------
function LimitWorkableCount_Building()
	local totalWorkCount	= Building_Info._subWork_Data[SubWork_List._selected_Index]._totalCount		-- 토탈 카운트
	local currentWorkCount	= Building_Info._subWork_Data[SubWork_List._selected_Index]._currentCount	-- 현재 카운트
	local workableCount		= totalWorkCount - currentWorkCount											-- 일 할 수 있는 카운트
	local resourceCount		= Building_Info._subWork_Data[SubWork_List._selected_Index]._haveCount		-- 재료 수
	local workerActionPoint	= Worker_List._data_Table[Worker_List._selected_Index]._currentPoint		-- 현재 행동력
	local ongoingCount		= Building_Info._subWork_Data[SubWork_List._selected_Index]._onGoingCount	-- 해당 작업에 붙어 있는 일꾼수(작업중인 일 수)
	
	local limitWorkableCount = 1
	if ( workableCount < resourceCount ) then
		limitWorkableCount = workableCount
	else
		limitWorkableCount = resourceCount
	end
	if ( workerActionPoint < limitWorkableCount ) then
		limitWorkableCount = workerActionPoint
	end

	return limitWorkableCount
end

local set_Workable_Count = function( inputNumber )
	BuildingWork_Progress_List._workingCount = Int64toInt32( inputNumber )
	defalut_Control._subWork_Estimated._Time_Count:SetShow( true )
	defalut_Control._subWork_Estimated._Time_Count:SetText( PAGetStringParam1( Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_WORKMANAGER_BUILDING_DEFAULT", "getWorkingCount", BuildingWork_Progress_List._workingCount ) ) -- "(" .. BuildingWork_Progress_List._workingCount .. "회)" )
	
end

function HandleClicked_WorkCount_Building()
	local s64_MaxWorkableCount = toInt64(0, LimitWorkableCount_Building())
	
	if toInt64(0, 0) >= s64_MaxWorkableCount then
		_PA_LOG("이문종", "일꾼이 작업할 수 없습니다.")
	else
		Panel_NumberPad_Show( true, s64_MaxWorkableCount, 0, set_Workable_Count, false )
	end
end

-----------------------------------------------------
-- 개별 작업 취소 Button 관련 함수
-----------------------------------------------------
local worker_StopWork = nil

function HandleClick_OnGoing_Cancel_Building(idx)
	local	buildingInfoSS	= ToClient_getBuildingInfo( buildingActorKey ); 

	if( nil == buildingInfoSS ) then
		return;
	end

	local index	 	= BuildingWork_Progress_List._offsetIndex + idx
	if nil ~= BuildingWork_Progress_List._workerList[index] then
		worker_StopWork	= BuildingWork_Progress_List._workerList[index]
	else
		return
	end
	local buildingName = PAGetStringParam2( Defines.StringSheet_GAME, "GAME_MESSAGE_HOUSE_HOD_NAME", "nickName", 
	ToClient_getBuildingOwnerName( buildingInfoSS ), "houseName", ToClient_getBuildTypeName( buildingInfoSS ) );
	local _workerNo = worker_StopWork:get_s64()
	local _leftWorkCount	= ToClient_getNpcWorkerWorkingCount(_workerNo)
	if _leftWorkCount < 1 then
		Proc_ShowMessage_Ack( PAGetString(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_WORKING_PROGRESS_LEFTWORKCOUNT_ACK") ) -- "1회 작업은 취소할 수 없습니다." )
		return
	else
		local esSSW 	= 0 -- ToClient_getItemExchangeSourceStaticStatusByWorking(_workerNo)
		local workName 	= tostring(buildingName) .. " : " .. tostring(Building_Info._subWork_Data[SubWork_List._selected_Index]._workName)
		
		local cancelWorkContent = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_LARGECRAFT_WORKMANAGER_CANCELWORK_CONTENT", "workName", workName)
		local messageboxData = { title = PAGetString(Defines.StringSheet_GAME, "LUA_LARGECRAFT_WORKMANAGER_CANCELWORK_TITLE" ), content = cancelWorkContent , functionYes = HandleClick_OnGoing_Cancel_Building_Continue, functionCancel = MessageBox_Empty_function, priority = UI_PP.PAUIMB_PRIORITY_LOW }
		MessageBox.showMessageBox(messageboxData, "top")
	end
end

function HandleClick_OnGoing_Cancel_Building_Continue()
	-- local isSuccess = ToClient_requestStopPlantWorking(worker_StopWork)
	-- if ( false == isSuccess ) then
	--     Proc_ShowMessage_Ack( PAGetString(Defines.StringSheet_GAME, "Lua_RentHouseNoWorkingByWorkerNotSelect") )
	-- end
	ToClient_requestCancelNextWorking( worker_StopWork )
	worker_StopWork = nil
end

-----------------------------------------------------
-- Event 관련 함수
-----------------------------------------------------
function FromClient_Buidling_StopWork(workerNo, isUserRequest)
	local	buildingInfoSS	= ToClient_getBuildingInfo( buildingActorKey ); 

	if( nil == buildingInfoSS ) then
		return;
	end

	if( false == Panel_Building_WorkManager:IsShow() ) then
		return
	end

	-- 일꾼 관련 함수 추가 후 조건 Check를 추가하자!
	FGlobal_Building_WorkManager_Refresh()
end

function FromClient_Buidling_StartWork(_buildingInfo)
	local	buildingInfoSS	= ToClient_getBuildingInfo( buildingActorKey ); 

	if( nil == buildingInfoSS ) then
		return;
	end
	
	if( false == Panel_Building_WorkManager:IsShow() ) then
		return
	end

	local _PlantKey_1 = ToClient_getBuildingPlantKey( buildingInfoSS ):get()
	local _PlantKey_2 = ToClient_getBuildingPlantKey( _buildingInfo ):get()
	
	if _PlantKey_1 == _PlantKey_2 then
		FGlobal_Building_WorkManager_Refresh()
	end
end

function FromClient_WareHouse_Update_ForBuilding(_affiliatedTownKey)
	local	buildingInfoSS	= ToClient_getBuildingInfo( buildingActorKey ); 
	if( nil == buildingInfoSS ) then
		return;
	end

	if( false == Panel_Building_WorkManager:IsShow() ) then
		return
	end
	if affiliatedTownKey == _affiliatedTownKey and true == Panel_Building_WorkManager:GetShow() then
		FGlobal_Building_WorkManager_Refresh()
	end
end

function FGlobal_Building_WorkManager_Refresh()
	local	buildingInfoSS	= ToClient_getBuildingInfo( buildingActorKey ); 
	
	if( nil == buildingInfoSS ) then
		return;
	end

	Building_Info:_setData(true)
	Worker_List:_setData()
			
	Building_Info:_update()
	SubWork_List:_updateSlot()
	Worker_List:_updateSlot()
		
	BuildingWork_Info_Update()
	if nil == Worker_List._selected_Index then
		Building_Worker_List_Select(1)
	end
end

function FromClient_CompleteBuilding(buildingInfo)
	local _building_GuildWrapper 	= ToClient_getGuildWrapper(buildingInfo)
	if nil == _building_GuildWrapper then
		return	-- 개인 텐트는 상관 없는 일!! (만약, 길드와 상관 없는 건축물이 생긴다면 변경해야 한다!)
	end

	-- 성채 제작 남은 시간 갱신을 위해 길드가 없어도 처리한다.
	local tempActorKey = buildingInfo:getActorKeyRaw()
	FGlobal_ReSet_SiegeBuildingName( tempActorKey )
	
	local	buildingInfoSS	= ToClient_getBuildingInfo( buildingActorKey ); 

	if( nil == buildingInfoSS ) then
		return;
	end

	local _building_GuildNo			= _building_GuildWrapper:getGuildNo_s64()
	
	local _myInfo_GuildWrapper 	= ToClient_GetMyGuildInfoWrapper()
	if nil == _myInfo_GuildWrapper then
		return	-- 길드가 없으면 상관 없는 일!
	end	
	local _myInfo_GuildNo		= _myInfo_GuildWrapper:getGuildNo_s64()
	
	if _building_GuildNo == _myInfo_GuildNo then
		local _building_Name = PAGetStringParam2( Defines.StringSheet_GAME, "GAME_MESSAGE_HOUSE_HOD_NAME", "nickName", 
	ToClient_getBuildingOwnerName( buildingInfoSS ), "houseName", ToClient_getBuildTypeName( buildingInfoSS ) )
		Proc_ShowMessage_Ack( PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLD_MAP_FINISH_BUILDING", "name", _building_Name) )	
		if true == Panel_Building_WorkManager:GetShow() then
			FGlobal_Building_WorkManager_Close()
		end
	end
end

Panel_Building_WorkManager			:RegisterUpdateFunc("BuildingWork_Progress_List_UpdateSlot")
registerEvent("WorldMap_StopWorkerWorking",				"FromClient_Buidling_StopWork")
registerEvent("WorldMap_WorkerDataUpdateByBuilding",	"FromClient_Buidling_StartWork")
registerEvent("EventWarehouseUpdate",					"FromClient_WareHouse_Update_ForBuilding")
registerEvent("FromClient_CompleteBuilding",			"FromClient_CompleteBuilding")
