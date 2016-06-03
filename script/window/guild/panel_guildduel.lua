local CT2S 			= CppEnums.ClassType2String
local UI_PSFT 		= CppEnums.PAUI_SHOW_FADE_TYPE
local UI_ANI_ADV 	= CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_color 		= Defines.Color
local UCT 			= CppEnums.PA_UI_CONTROL_TYPE
local UI_TM 		= CppEnums.TextMode
local IM 			= CppEnums.EProcessorInputMode

Panel_GuildDuel:SetShow ( false )

local GuildDuel = {
	ui      = {
		_btn_Confirm		= UI.getChildControl ( Panel_GuildDuel,  "Button_Confirm"),
		_btn_Cancel			= UI.getChildControl ( Panel_GuildDuel,  "Button_Cancel"),
		_btn_Close			= UI.getChildControl ( Panel_GuildDuel,  "Button_Win_Close"),
		_btn_Help			= UI.getChildControl ( Panel_GuildDuel,  "Button_Help"),
		

		_static_GuildMarkBG	= UI.getChildControl ( Panel_GuildDuel,  "Static_GuildMarkBG"),
		_static_GuildMark	= UI.getChildControl ( Panel_GuildDuel,  "Static_GuildMark"),
		_txt_GuildName		= UI.getChildControl ( Panel_GuildDuel,  "StaticText_GuildName"),
		_txt_GuildMaster	= UI.getChildControl ( Panel_GuildDuel,  "StaticText_GuildMaster"),
		_txt_DuelNotify		= UI.getChildControl ( Panel_GuildDuel,  "StaticText_Notify"),

		_radio_kill    = {
			[0] = UI.getChildControl ( Panel_GuildDuel,  "RadioButton_KillCount_0"),
			[1] = UI.getChildControl ( Panel_GuildDuel,  "RadioButton_KillCount_1"),
			[2] = UI.getChildControl ( Panel_GuildDuel,  "RadioButton_KillCount_2"),
		},
		_radio_betting	= {
			[0] = UI.getChildControl ( Panel_GuildDuel,  "RadioButton_Betting_0"),
			[1] = UI.getChildControl ( Panel_GuildDuel,  "RadioButton_Betting_1"),
			[2] = UI.getChildControl ( Panel_GuildDuel,  "RadioButton_Betting_2"),
			[3] = UI.getChildControl ( Panel_GuildDuel,  "RadioButton_Betting_3"),
			[4] = UI.getChildControl ( Panel_GuildDuel,  "RadioButton_Betting_4"),
		}
	},

	config  = {
		guildNo_s64 = toInt64(0,0)
	},

	duelConditon = {
		kill = { 
			[0] = 5, 
			[1] = 600, 
			[2] = 1000
		},
		betting = {
			[0] = 30000,
			[1] = 6000000,
			[2] = 10000000,
			[3] = 50000000,
			[4] = 100000000,
		}
	},
}
GuildDuel.ui._txt_GuildMaster:SetShow( false )	-- 나중에 켠다. 클라 작업 필요. (15.10.30 김창욱.)


function GuildDuel:Init()
	for killIdx = 0, #GuildDuel.ui._radio_kill do
		local targetKill = ToClient_GetGuildDuelTargetKillListAt(killIdx)
		local killScore = makeDotMoney(toInt64(0,targetKill))
		GuildDuel.ui._radio_kill[killIdx]:SetText( PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDDUEL_VICTORYCOUNT", "killCount", killScore ) ) -- "{killCount} 킬"
	end

	for bettingIdx = 0, #GuildDuel.ui._radio_betting do
		local betting = ToClient_GetGuildDuelBettingListAt(bettingIdx)
		local bettingMoney = makeDotMoney(toInt64(0,betting))
		GuildDuel.ui._radio_betting[bettingIdx]:SetText( PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDDUEL_BETTING_MONEY", "VictoryCount", bettingMoney ) )	-- "{VictoryCount} 은화"
	end

	self.ui._txt_DuelNotify:SetTextMode( UI_TM.eTextMode_AutoWrap )
	self.ui._txt_DuelNotify:SetAutoResize( true )
	self.ui._txt_DuelNotify:SetText( PAGetString(Defines.StringSheet_GAME, "LUA_GUILDDUELNOTIFY") )	-- "- 한 번 시작된 결전은 임의로 종료할 수 없습니다.\n- 배팅만큼 길드 자금이 있어야 합니다.\n- 승리 보상은 배팅은*2에서 20%를 제외한 만큼입니다."
end

function GuildDuel:registEventHandler()
	self.ui._btn_Confirm	:addInputEvent( "Mouse_LUp", "HandleClicked_GuildDuel_Confirm()" )
	self.ui._btn_Cancel		:addInputEvent( "Mouse_LUp", "HandleClicked_GuildDuel_Cancel()" )
	self.ui._btn_Close		:addInputEvent( "Mouse_LUp", "HandleClicked_GuildDuel_Cancel()" )
	self.ui._btn_Help		:addInputEvent( "Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelGuild\" )" )
end
function GuildDuel:registMessageHandler()
	registerEvent("FromClient_RequestGuildDuel",					"FromClient_RequestGuildDuel");
end

function GuildDuel:Update()
	local GuildWarInfoWrapper = ToClient_GetWarringGuildInfoByGuildNo( self.config.guildNo_s64 )
	if nil ~= GuildWarInfoWrapper then
		-- 길드 마크 세팅
		local isSet = false
		if GuildWarInfoWrapper:isExist() then
			isSet = setGuildTextureByGuildNo( self.config.guildNo_s64, self.ui._static_GuildMark )
		end
		if ( false == isSet ) then
			self.ui._static_GuildMark:ChangeTextureInfoName("New_UI_Common_forLua/Default/Default_Buttons.dds")
			local x1, y1, x2, y2 = setTextureUV_Func( self.ui._static_GuildMark, 183, 1, 188, 6 )
			self.ui._static_GuildMark:getBaseTexture():setUV(  x1, y1, x2, y2  )
			self.ui._static_GuildMark:setRenderTexture(self.ui._static_GuildMark:getBaseTexture())
		else	
			self.ui._static_GuildMark:getBaseTexture():setUV(  0, 0, 1, 1  )
			self.ui._static_GuildMark:setRenderTexture(self.ui._static_GuildMark:getBaseTexture())
		end

		-- 길드명 세팅
		self.ui._txt_GuildName:SetText( GuildWarInfoWrapper:getGuildName() )

		-- 길드대장 세팅
		-- self.ui._txt_GuildMaster:SetText( GuildWarInfoWrapper:getGuildMasterName() )
	else
		Proc_ShowMessage_Ack( PAGetString(Defines.StringSheet_GAME, "LUA_DIALOGUE_NPCSHOP_GUILD1") )	-- "길드가 없습니다."
	end
end

function FGlobal_GuildDuel_Open( guildNo_s64 )
	GuildDuel.config.guildNo_s64 = guildNo_s64
	Panel_GuildDuel:SetShow( true )
	GuildDuel:Update()
end

function FGlobal_GuildDuel_Close()
	GuildDuel.config.guildNo_s64	= toInt64(0, 0)
	Panel_GuildDuel:SetShow( false )
end

function HandleClicked_GuildDuel_Confirm()
	local selected_KillNo	= nil
	local selected_Kill		= false
	for killIdx = 0, #GuildDuel.ui._radio_kill do
		if GuildDuel.ui._radio_kill[killIdx]:IsCheck() then
			selected_KillNo = killIdx
			selected_Kill	= true
			break
		end
	end

	local selected_BettingNo	= nil
	local selected_Betting		= false
	for bettingIdx = 0, #GuildDuel.ui._radio_betting do
		if GuildDuel.ui._radio_betting[bettingIdx]:IsCheck() then
			selected_BettingNo	= bettingIdx
			selected_Betting	= true
			break
		end
	end

	if false == selected_Kill or false == selected_Betting then
		Proc_ShowMessage_Ack( PAGetString(Defines.StringSheet_GAME, "LUA_GUILDDUEL_MUSTBE_SELECT") )	-- "승리 조건과 베팅을 선택해야 합니다."
		return
	end

	ToClient_RequestDeclareGuildDuel( GuildDuel.config.guildNo_s64, ToClient_GetGuildDuelTargetKillListAt(selected_KillNo), ToClient_GetGuildDuelBettingListAt(selected_BettingNo) )	-- 결전을 신청한다.

	HandleClicked_GuildDuel_Cancel()	-- 신청했으니 끝낸다.
end

function HandleClicked_GuildDuel_Cancel()
	GuildDuel.config.guildNo_s64	= toInt64(0, 0)
	Panel_GuildDuel:SetShow( false )
end



----------------------------------------------------------------------------------------------------------------
--	길드 결전 요청
----------------------------------------------------------------------------------------------------------------
local duelTargetUserNo 		= 0
local duelTargetGuildNo 	= 0
local duelTargetKill 		= 0
local duelBet				= 0
function FromClient_RequestGuildDuel( userNo, guildNo, guildName, targetKill, bet )
	if(MessageBox.isPopUp() and (targetGuildNo == guildNo)) then
		return
	end
	
	duelTargetUserNo	= userNo
	duelTargetGuildNo 	= guildNo
	duelTargetKill		= targetKill
	duelBet				= bet

	local	messageBoxMemo = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_DECLAREDUEL", "guildName", guildName, "killCount", makeDotMoney(targetKill), "bettingCount", makeDotMoney(bet) )
	local	messageBoxData = { title = PAGetString ( Defines.StringSheet_GAME, "LUA_WARNING"), content = messageBoxMemo, functionYes = FGlobal_AcceptGuildDuel, functionNo = FGlobal_RefuseGuildDuel, priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW}
	MessageBox.showMessageBox(messageBoxData)
end

function FGlobal_AcceptGuildDuel()
	ToClient_RequestAcceptGuildDuel(duelTargetGuildNo, duelTargetKill, duelBet)
	duelTargetUserNo 	= 0
	duelTargetGuildNo 	= 0
end

function FGlobal_RefuseGuildDuel()
	ToClient_RequestRefuseGuildDuel(duelTargetUserNo, duelTargetGuildNo)
	duelTargetUserNo 	= 0
	duelTargetGuildNo 	= 0
end


GuildDuel:Init()
GuildDuel:registEventHandler()
GuildDuel:registMessageHandler()