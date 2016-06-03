local UI_PUCT		= CppEnums.PA_UI_CONTROL_TYPE
local UI_color		= Defines.Color
local UI_TM 		= CppEnums.TextMode
local UI_ANI_ADV 	= CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_PSFT 		= CppEnums.PAUI_SHOW_FADE_TYPE

Panel_Interaction_HouseRank:SetShow( false )
Panel_Interaction_HouseRank:ActiveMouseEventEffect(true)
Panel_Interaction_HouseRank:setGlassBackground(true)

Panel_Interaction_HouseRank:RegisterShowEventFunc( true, 'Panel_Interaction_HouseRank_ShowAni()' )
Panel_Interaction_HouseRank:RegisterShowEventFunc( false, 'Panel_Interaction_HouseRank_HideAni()' )

------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
local copyUi = {
	_copyRank		= UI.getChildControl ( Panel_Interaction_HouseRank, "StaticText_C_Rank" ),
	_copyRanker		= UI.getChildControl ( Panel_Interaction_HouseRank, "StaticText_C_Ranker" ),
	_copyScore		= UI.getChildControl ( Panel_Interaction_HouseRank, "StaticText_C_Score" ),
	_copyScreenShot	= UI.getChildControl ( Panel_Interaction_HouseRank, "Button_Screenshot" ),
}

copyUi._copyRank:SetShow(false)
copyUi._copyRanker:SetShow(false)
copyUi._copyScore:SetShow(false)
copyUi._copyScreenShot:SetShow(false)

local houseRanklistBG	= UI.getChildControl ( Panel_Interaction_HouseRank, "Static_ListBG" )

local buttonClose = UI.getChildControl( Panel_Interaction_HouseRank, "Button_CloseWindow" )
buttonClose:addInputEvent(	"Mouse_LUp", "Panel_Interaction_HouseRanke_Close()" )
local buttonX = UI.getChildControl( Panel_Interaction_HouseRank, "Button_Close" )
buttonX:addInputEvent(	"Mouse_LUp", "Panel_Interaction_HouseRanke_Close()" )
local noRank = UI.getChildControl( Panel_Interaction_HouseRank, "StaticText_No_Rank" )

local UI_LIST = {}


------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

------------------------------------
--			각종 변수들
local rankCount = 10		-- 패널에 10개 까지만 표시해준다!
local listGap	= 28




------------------------------------------------------------------------------------------------
--									켜고 끄는 함수들
------------------------------------------------------------------------------------------------
function Panel_Interaction_HouseRank_ShowAni()
	-- Panel_Interaction_HouseRank:SetShow( true )
	UIAni.AlphaAnimation( 1, Panel_Interaction_HouseRank, 0.0, 0.2 )
end

function Panel_Interaction_HouseRank_HideAni()
	local aniInfo = UIAni.AlphaAnimation( 0, Panel_Interaction_HouseRank, 0.0, 0.2 )
	aniInfo:SetHideAtEnd(true)
end



------------------------------------------------------------------------------------------------
--							SHOW TOGGLE 로 동작하는 것이 맞을지?
------------------------------------------------------------------------------------------------
function Panel_Interaction_HouseRank_ShowToggle()
	-- @@@@@ 조건 개선이 필요!!!!!!
	if ( Panel_Interaction:IsShow() ) then
		local posX = Panel_Interaction_GetGlobalGuidePosX()
		local posY = Panel_Interaction_GetGlobalGuidePosY()
		
		Panel_Interaction_HouseRank:SetPosX( posX )
		Panel_Interaction_HouseRank:SetPosY( posY )
	
		Panel_Interaction_HouseRank:SetShow( false, false )
	else
		Panel_Interaction_HouseRank:SetShow( true, true )
	end
end



------------------------------------------------------------------------------------------------
--									최초 초기화 함수
------------------------------------------------------------------------------------------------
function Panel_Interaction_HouseRank_Init()
	Panel_Interaction_HouseRank_MakeControl()	-- 멬잇빼스트
end



------------------------------------------------------------------------------------------------
--								컨트롤을 아름답게 생성한다
------------------------------------------------------------------------------------------------
function Panel_Interaction_HouseRank_MakeControl()
	local startPosY = 44
	-- 정해진 카운트 내에서 10개만 생성한다
	for index = 0, rankCount-1, 1 do
		
		local ui = {}
		
		ui._rank = UI.createControl( UI_PUCT.PA_UI_CONTROL_STATICTEXT, Panel_Interaction_HouseRank, 'StaticText_Rank_' .. index )
		CopyBaseProperty( copyUi._copyRank,	ui._rank )
		--UI.deleteControl( copyUi._copyRank )
		
		ui._ranker = UI.createControl( UI_PUCT.PA_UI_CONTROL_STATICTEXT, Panel_Interaction_HouseRank, 'StaticText_Ranker_' .. index )
		CopyBaseProperty( copyUi._copyRanker,	ui._ranker )
		--UI.deleteControl( copyUi._copyRanker )
		
		ui._score = UI.createControl( UI_PUCT.PA_UI_CONTROL_STATICTEXT, Panel_Interaction_HouseRank, 'StaticText_Score_' .. index )
		CopyBaseProperty( copyUi._copyScore,	ui._score )
		--UI.deleteControl( copyUi._copyScore )

		ui._screenShot = UI.createControl( UI_PUCT.PA_UI_CONTROL_BUTTON, Panel_Interaction_HouseRank, 'Button_ScreenShot_' .. index )
		CopyBaseProperty( copyUi._copyScreenShot,	ui._screenShot )
		ui._screenShot:addInputEvent("Mouse_LUp", "")
		ui._screenShot:SetShow(false)

		local tempPosY = startPosY + (listGap * index)
		ui._rank:SetPosY( tempPosY )
		ui._ranker:SetPosY( tempPosY )
		ui._score:SetPosY( tempPosY )
		ui._screenShot:SetPosY( tempPosY )
		
		UI_LIST[index] = ui
	end
end

-------------------------------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------------------------------
function Panel_Interaction_HouseRank_Update( size )
	local panel_SizeCheck = 0
	for index = 0, rankCount-1, 1 do
		local ui = UI_LIST[index]
		
		local userName = housing_getHouseRankerName(index)
		local point = housing_getHouseRankerPoint(index)
		local isShow = false
		if( 0 < string.len(userName) ) then
			isShow = true
		else
			isShow = false;
		end
		
		if ( 0 == index ) then								-- 랭크가 없다면 문구 노출
			if ( 0 == string.len(userName) ) then
				noRank:SetShow( true )
				noRank:SetText( PAGetString(Defines.StringSheet_GAME, "LUA_HOUSERANK_Norank" ) ) -- 주거지로 설정된 집이 없습니다.
			else
				noRank:SetShow( false )
			end
		end
		
		ui._rank:SetShow(isShow)
		ui._ranker:SetShow(isShow)
		ui._score:SetShow(isShow)
		-- ui._screenShot:SetShow(isShow)
		------------------------------------------
		--		1위인 놈 색만 바꿔준듸
		if ( index == 0 ) then
			ui._rank:SetText( PAGetStringParam1( Defines.StringSheet_GAME, "LUA_HOUSERANK_Rank1", "RankNum1", tostring(index+1) ) )
			ui._ranker:SetText( PAGetStringParam1( Defines.StringSheet_GAME, "LUA_HOUSERANK_Ranker1", "userName", userName ) )
			ui._score:SetText( PAGetStringParam1( Defines.StringSheet_GAME, "LUA_HOUSERANK_Score1", "point", point ) )
		else
			ui._rank:SetText( PAGetStringParam1( Defines.StringSheet_GAME, "LUA_HOUSERANK_Rank2", "RankNum2", tostring(index+1) ) )
			ui._ranker:SetText( PAGetStringParam1( Defines.StringSheet_GAME, "LUA_HOUSERANK_Ranker2", "userName", userName ) )
			ui._score:SetText( PAGetStringParam1( Defines.StringSheet_GAME, "LUA_HOUSERANK_Score2", "point", point ) )
		end

		panel_SizeCheck = panel_SizeCheck + listGap
		
	end
	Panel_Interaction_HouseRank:SetSize( Panel_Interaction_HouseRank:GetSizeX(), panel_SizeCheck + 90 )
	houseRanklistBG:SetSize( houseRanklistBG:GetSizeX(), panel_SizeCheck + 10 )
	buttonClose:SetPosY( panel_SizeCheck + 55 )

	local scrSizeX = getScreenSizeX()
	local scrSizeY = getScreenSizeY()
	local posX = scrSizeX - (scrSizeX/2) + (Panel_Interaction_HouseRank:GetSizeY()/3)
	local posY = scrSizeY - (scrSizeY/2) - (Panel_Interaction_HouseRank:GetSizeY()/2)
	
	Panel_Interaction_HouseRank:SetPosX( string.format( "%.0f", posX ) )
	Panel_Interaction_HouseRank:SetPosY( string.format( "%.0f", posY ) )

	Panel_Interaction_HouseRank:SetShow( true, true )
end

function Panel_Interaction_HouseRanke_Close()
	Panel_Interaction_HouseRank:SetShow( false, false )
end

Panel_Interaction_HouseRank_Init()

registerEvent( "EventUpdateHouseRankerList",	"Panel_Interaction_HouseRank_Update" )

local 	_buttonQuestion = UI.getChildControl( Panel_Interaction_HouseRank, "Button_Question" )				-- 물음표 버튼
_buttonQuestion:addInputEvent( "Mouse_LUp", "Panel_WebHelper_ShowToggle( \"HouseRank\" )" )					-- 물음표 좌클릭
_buttonQuestion:addInputEvent( "Mouse_On",	"HelpMessageQuestion_Show( \"HouseRank\", \"true\")" )			-- 물음표 마우스오버
_buttonQuestion:addInputEvent( "Mouse_Out", "HelpMessageQuestion_Show( \"HouseRank\", \"false\")" )			-- 물음표 마우스오버