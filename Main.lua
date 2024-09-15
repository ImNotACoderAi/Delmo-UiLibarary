-- Services
local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")
local localPlayer = game:GetService("Players").LocalPlayer
local coreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")
local mouse = localPlayer:GetMouse()
local Camera = workspace.CurrentCamera
stop = false
stopforce = false

-- Utilities
do
	function ValidateS(defaults, options)
		for i, v in pairs(defaults) do
			if options[i] == nil then
				options[i] = v
			end
		end
		return options
	end

	function Tween(object, goal, duration, callback)
		local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
		local tween = tweenService:Create(object, tweenInfo, goal)
		if callback then
			tween.Completed:Connect(callback)
		end
		tween:Play()
	end

	local userInputService = game:GetService("UserInputService")

	function NOTSTOLENDRAG(Rizzler)
		local dragging = false
		local dragInput, touchInput, mousePos, framePos

		local function update(input)
			local delta = input.Position - mousePos
			local newPosition = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
			Tween(Rizzler, {Position = newPosition}, 0.2)
		end

		Rizzler.InputBegan:Connect(function(input)
			if (input.UserInputType == Enum.UserInputType.MouseButton1 and stop ~= true and stopforce ~= true or input.UserInputType == Enum.UserInputType.Touch) and stop ~= true and stopforce ~= true then
				dragging = true
				mousePos = input.Position
				framePos = Rizzler.Position
				if UIS.TouchEnabled then
					UIS.MouseBehavior = Enum.MouseBehavior.LockCenter
					UIS.ModalEnabled = true
					Camera.CameraType = Enum.CameraType.Scriptable
				end

				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragging = false
						if UIS.TouchEnabled then
							UIS.MouseBehavior = Enum.MouseBehavior.Default
							UIS.ModalEnabled = false
							Camera.CameraType = Enum.CameraType.Custom
						end
					end
				end)
			end
		end)

		Rizzler.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				dragInput = input
			end
		end)

		UIS.InputChanged:Connect(function(input)
			if (input == dragInput or input == touchInput) and dragging and stop ~= true and stopforce ~= true then
				update(input)
			end
		end)
	end
end

-- Main
do
	Notify = {}

	if UIS.TouchEnabled then
		UISIZE = UDim2.new(0, 370, 0, 220)
	else
		UISIZE = UDim2.new(0, 470, 0, 320)
	end

	function Init(options)
		local options = ValidateS({
			Title = "TEKKIT AoT:R",
			Socials = false,
			Discord = "",
			Youtube = ""
		}, options or {})

		UI = {
			CurrentTab = nil,
			ExitHover = false,
			MinimizeHover = false,
			MaximizeHover = false,
			Maximized = false
		}

		-- Main Window
		do
			-- StarterGui.bombaclat
			UI["1"] = Instance.new("ScreenGui", runService:IsStudio() and localPlayer:WaitForChild("PlayerGui") or coreGui);
			UI["1"]["IgnoreGuiInset"] = true;
			UI["1"]["ScreenInsets"] = Enum.ScreenInsets.DeviceSafeInsets;
			UI["1"]["Name"] = [[bombaclat]];
			UI["1"]["ResetOnSpawn"] = false;

			-- StarterGui.bombaclat.Navigation
			UI["61"] = Instance.new("Frame", UI["1"]);
			UI["61"]["BorderSizePixel"] = 0;
			UI["61"]["BackgroundColor3"] = Color3.fromRGB(13, 13, 13);
			UI["61"]["AnchorPoint"] = Vector2.new(0.5, 0);
			UI["61"]["Size"] = UDim2.new(0, 155, 0, 30);
			UI["61"]["Position"] = UDim2.new(0.5, 0, 0, 5);
			UI["61"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			UI["61"]["Name"] = [[Navigation]];
			
			-- StarterGui.bombaclat.Navigation.Youtube
			UI["68"] = Instance.new("ImageLabel", UI["61"]);
			UI["68"]["AnchorPoint"] = Vector2.new(0, 0.5);
			UI["68"]["Image"] = [[rbxassetid://15199293149]];
			UI["68"]["Size"] = UDim2.new(0, 20, 0, 20);
			UI["68"]["BackgroundTransparency"] = 1;
			UI["68"]["Name"] = [[Youtube]];
			UI["68"]["Position"] = UDim2.new(0, 5, 0.5, 0);


			-- StarterGui.bombaclat.Navigation.Discord
			UI["69"] = Instance.new("ImageLabel", UI["61"]);
			UI["69"]["AnchorPoint"] = Vector2.new(1, 0.5);
			UI["69"]["Image"] = [[rbxassetid://127970682686597]];
			UI["69"]["Size"] = UDim2.new(0, 20, 0, 20);
			UI["69"]["BackgroundTransparency"] = 1;
			UI["69"]["Name"] = [[Discord]];
			UI["69"]["Position"] = UDim2.new(1, -5, 0.5, 0);

			-- StarterGui.bombaclat.Navigation.UICorner
			UI["62"] = Instance.new("UICorner", UI["61"]);
			UI["62"]["CornerRadius"] = UDim.new(0, 6);


			-- StarterGui.bombaclat.Navigation.DropShadowHolder
			UI["63"] = Instance.new("Frame", UI["61"]);
			UI["63"]["ZIndex"] = 0;
			UI["63"]["BorderSizePixel"] = 0;
			UI["63"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
			UI["63"]["Size"] = UDim2.new(1, -15, 1, -15);
			UI["63"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
			UI["63"]["Name"] = [[DropShadowHolder]];
			UI["63"]["BackgroundTransparency"] = 1;


			-- StarterGui.bombaclat.Navigation.DropShadowHolder.DropShadow
			UI["64"] = Instance.new("ImageLabel", UI["63"]);
			UI["64"]["ZIndex"] = 0;
			UI["64"]["BorderSizePixel"] = 0;
			UI["64"]["SliceCenter"] = Rect.new(49, 49, 450, 450);
			UI["64"]["ScaleType"] = Enum.ScaleType.Slice;
			UI["64"]["ImageTransparency"] = 0.5;
			UI["64"]["ImageColor3"] = Color3.fromRGB(0, 0, 0);
			UI["64"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
			UI["64"]["Image"] = [[rbxassetid://6014261993]];
			UI["64"]["Size"] = UDim2.new(1, 47, 1, 47);
			UI["64"]["BackgroundTransparency"] = 1;
			UI["64"]["Name"] = [[DropShadow]];
			UI["64"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


			-- StarterGui.bombaclat.Navigation.Exit
			UI["65"] = Instance.new("ImageLabel", UI["61"]);
			UI["65"]["AnchorPoint"] = Vector2.new(0, 0.5);
			UI["65"]["Image"] = [[rbxassetid://13857933221]];
			UI["65"]["Size"] = UDim2.new(0, 20, 0, 20);
			UI["65"]["BackgroundTransparency"] = 1;
			UI["65"]["ZIndex"] = 69420;
			UI["65"]["Name"] = [[Exit]];
			UI["65"]["Position"] = UDim2.new(0, 37, 0.5, 0);


			-- StarterGui.bombaclat.Navigation.Maximize
			UI["66"] = Instance.new("ImageLabel", UI["61"]);
			UI["66"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
			UI["66"]["Image"] = [[rbxassetid://13867974624]];
			UI["66"]["Size"] = UDim2.new(0, 20, 0, 20);
			UI["66"]["BackgroundTransparency"] = 1;
			UI["66"]["Name"] = [[Maximize]];
			UI["66"]["ZIndex"] = 69420;
			UI["66"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


			-- StarterGui.bombaclat.Navigation.Minimize
			UI["67"] = Instance.new("ImageLabel", UI["61"]);
			UI["67"]["AnchorPoint"] = Vector2.new(1, 0.5);
			UI["67"]["Image"] = [[rbxassetid://13867976290]];
			UI["67"]["Size"] = UDim2.new(0, 20, 0, 20);
			UI["67"]["BackgroundTransparency"] = 1;
			UI["67"]["ZIndex"] = 69420;
			UI["67"]["Name"] = [[Minimize]];
			UI["67"]["Position"] = UDim2.new(1, -37, 0.5, 0);

			-- StarterGui.bombaclat.Notifs Holder
			UI["4f"] = Instance.new("Frame", UI["1"]);
			UI["4f"]["BorderSizePixel"] = 0;
			UI["4f"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			UI["4f"]["Name"] = [[Notifs Holder]];
			UI["4f"]["AnchorPoint"] = Vector2.new(1, 0);
			UI["4f"]["ClipsDescendants"] = false;
			UI["4f"]["Size"] = UDim2.new(0, 180, 1, 0);
			UI["4f"]["Position"] = UDim2.new(1, 0, 0, 0);
			UI["4f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			UI["4f"]["BackgroundTransparency"] = 1;

			-- StarterGui.bombaclat.Notifs Holder.UIListLayout
			UI["57"] = Instance.new("UIListLayout", UI["4f"]);
			UI["57"]["Padding"] = UDim.new(0, 5);
			UI["57"]["VerticalAlignment"] = Enum.VerticalAlignment.Bottom;
			UI["57"]["SortOrder"] = Enum.SortOrder.LayoutOrder;


			-- StarterGui.bombaclat.Notifs Holder.UIPadding
			UI["58"] = Instance.new("UIPadding", UI["4f"]);
			UI["58"]["PaddingTop"] = UDim.new(0, 5);
			UI["58"]["PaddingRight"] = UDim.new(0, 5);
			UI["58"]["PaddingLeft"] = UDim.new(0, 5);
			UI["58"]["PaddingBottom"] = UDim.new(0, 5);

			-- StarterGui.bombaclat.UI
			UI["2"] = Instance.new("Frame", UI["1"])
			UI["2"]["BorderSizePixel"] = 0
			UI["2"]["BackgroundColor3"] = Color3.fromRGB(13, 13, 13)
			UI["2"]["AnchorPoint"] = Vector2.new(0.5, 0.5)
			UI["2"]["Position"] = UDim2.new(0.5, 0, 0.5, 0)
			UI["2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
			UI["2"]["Name"] = "UI"
			UI["2"]["Size"] = UISIZE

			-- StarterGui.bombaclat.UI.UICorner
			UI["3"] = Instance.new("UICorner", UI["2"]);
			UI["3"]["CornerRadius"] = UDim.new(0, 6);


			-- StarterGui.bombaclat.UI.Shadow
			UI["4"] = Instance.new("Frame", UI["2"]);
			UI["4"]["ZIndex"] = 0;
			UI["4"]["BorderSizePixel"] = 0;
			UI["4"]["Size"] = UDim2.new(1, 0, 1, 0);
			UI["4"]["Name"] = [[Shadow]];
			UI["4"]["BackgroundTransparency"] = 1;


			-- StarterGui.bombaclat.UI.Shadow.Shadow
			UI["5"] = Instance.new("ImageLabel", UI["4"]);
			UI["5"]["ZIndex"] = 0;
			UI["5"]["BorderSizePixel"] = 0;
			UI["5"]["SliceCenter"] = Rect.new(49, 49, 450, 450);
			UI["5"]["ScaleType"] = Enum.ScaleType.Slice;
			UI["5"]["ImageTransparency"] = 0.2;
			UI["5"]["ImageColor3"] = Color3.fromRGB(0, 0, 0);
			UI["5"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
			UI["5"]["Image"] = [[rbxassetid://6014261993]];
			UI["5"]["Size"] = UDim2.new(1, 47, 1, 47);
			UI["5"]["BackgroundTransparency"] = 1;
			UI["5"]["Name"] = [[Shadow]];
			UI["5"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


			-- StarterGui.bombaclat.UI.Divider
			UI["6"] = Instance.new("Frame", UI["2"]);
			UI["6"]["BorderSizePixel"] = 0;
			UI["6"]["BackgroundColor3"] = Color3.fromRGB(19, 19, 19);
			UI["6"]["Size"] = UDim2.new(0, 1, 1, 0);
			UI["6"]["Position"] = UDim2.new(0, 120, 0, 0);
			UI["6"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			UI["6"]["Name"] = [[Divider]];


			-- StarterGui.bombaclat.UI.NavArea
			UI["7"] = Instance.new("Frame", UI["2"]);
			UI["7"]["BorderSizePixel"] = 0;
			UI["7"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			UI["7"]["Size"] = UDim2.new(0, 120, 1, 0);
			UI["7"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			UI["7"]["Name"] = [[NavArea]];
			UI["7"]["BackgroundTransparency"] = 1;


			-- StarterGui.bombaclat.UI.NavArea.Title
			UI["8"] = Instance.new("TextLabel", UI["7"]);
			UI["8"]["TextWrapped"] = true;
			UI["8"]["BorderSizePixel"] = 0;
			UI["8"]["TextYAlignment"] = Enum.TextYAlignment.Top;
			UI["8"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			UI["8"]["TextSize"] = 24;
			UI["8"]["FontFace"] = Font.new([[rbxasset://fonts/families/Roboto.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
			UI["8"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			UI["8"]["BackgroundTransparency"] = 1;
			UI["8"]["AnchorPoint"] = Vector2.new(0.5, 0);
			UI["8"]["Size"] = UDim2.new(1, 0, 0, 60);
			UI["8"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			UI["8"]["Text"] = options["Title"];
			UI["8"]["Name"] = [[Title]];
			UI["8"]["Position"] = UDim2.new(0.5, 0, 0, 20);


			-- StarterGui.bombaclat.UI.NavArea.Nav
			UI["9"] = Instance.new("ScrollingFrame", UI["7"]);
			UI["9"]["Active"] = true;
			UI["9"]["BorderSizePixel"] = 0;
			UI["9"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			UI["9"]["Name"] = [[Nav]];
			UI["9"]["Size"] = UDim2.new(1, 0, 1, -76);
			UI["9"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
			UI["9"]["Position"] = UDim2.new(0, 0, 0, 76);
			UI["9"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			UI["9"]["ScrollBarThickness"] = 0;
			UI["9"]["BackgroundTransparency"] = 1;

			-- StarterGui.bombaclat.UI.NavArea.Nav.UIListLayout
			UI["10"] = Instance.new("UIListLayout", UI["9"]);
			UI["10"]["Padding"] = UDim.new(0, 5);
			UI["10"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

			-- StarterGui.bombaclat.UI.MainArea
			UI["14"] = Instance.new("Frame", UI["2"]);
			UI["14"]["BorderSizePixel"] = 0;
			UI["14"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			UI["14"]["Size"] = UDim2.new(1, -120, 1, 0);
			UI["14"]["Position"] = UDim2.new(0, 120, 0, 0);
			UI["14"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			UI["14"]["Name"] = [[MainArea]];
			UI["14"]["BackgroundTransparency"] = 1;
		end
		-- Tab
		do
			function UI:Tab(options)
				options = ValidateS({
					Title = "Preview Tab"
				}, options or {})

				local Tab = {
					Hover = false,
					Active = false
				}

				-- Rendering
				do
					-- StarterGui.bombaclat.UI.NavArea.Nav.Tab
					Tab["a"] = Instance.new("TextLabel", UI["9"]);
					Tab["a"]["BorderSizePixel"] = 0;
					Tab["a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Tab["a"]["TextSize"] = 13;
					Tab["a"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
					Tab["a"]["TextColor3"] = Color3.fromRGB(101, 101, 101);
					Tab["a"]["BackgroundTransparency"] = 1;
					Tab["a"]["Size"] = UDim2.new(1, 0, 0, 25);
					Tab["a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Tab["a"]["Text"] = options["Title"];
					Tab["a"]["Name"] = [[Tab]];


					-- StarterGui.bombaclat.UI.NavArea.Nav.Tab.Activated
					Tab["b"] = Instance.new("Frame", Tab["a"]);
					Tab["b"]["BorderSizePixel"] = 0;
					Tab["b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Tab["b"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
					Tab["b"]["Size"] = UDim2.new(0, 0, 0, 0);
					Tab["b"]["Position"] = UDim2.new(0, 0, 0.5, 0);
					Tab["b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Tab["b"]["Name"] = [[Activated]];


					-- StarterGui.bombaclat.UI.NavArea.Nav.Tab.Activated.UICorner
					Tab["c"] = Instance.new("UICorner", Tab["b"]);
					Tab["c"]["CornerRadius"] = UDim.new(0, 6);

					-- StarterGui.bombaclat.UI.MainArea.CurrentTab
					Tab["15"] = Instance.new("TextLabel", UI["14"]);
					Tab["15"]["BorderSizePixel"] = 0;
					Tab["15"]["Visible"] = false;
					Tab["15"]["TextXAlignment"] = Enum.TextXAlignment.Left;
					Tab["15"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Tab["15"]["TextSize"] = 16;
					Tab["15"]["FontFace"] = Font.new([[rbxasset://fonts/families/Roboto.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
					Tab["15"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
					Tab["15"]["BackgroundTransparency"] = 1;
					Tab["15"]["Size"] = UDim2.new(0, 90, 0, 10);
					Tab["15"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Tab["15"]["Text"] = Tab["a"]["Text"];
					Tab["15"]["Name"] = [[CurrentTab]];
					Tab["15"]["Position"] = UDim2.new(0, 15, 0, 25);

					-- StarterGui.bombaclat.UI.MainArea.Tab
					Tab["16"] = Instance.new("ScrollingFrame", UI["14"]);
					Tab["16"]["Active"] = true;
					Tab["16"]["Visible"] = false;
					Tab["16"]["BorderSizePixel"] = 0;
					Tab["16"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Tab["16"]["Name"] = [[Tab]];
					Tab["16"]["AnchorPoint"] = Vector2.new(0, 1);
					Tab["16"]["Size"] = UDim2.new(1, -10, 1, -55);
					Tab["16"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
					Tab["16"]["Position"] = UDim2.new(0, 5, 1, -5);
					Tab["16"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
					Tab["16"]["ScrollBarThickness"] = 0;
					Tab["16"]["BackgroundTransparency"] = 1;

					-- StarterGui.bombaclat.UI.MainArea.Tab.UIListLayout
					Tab["1f"] = Instance.new("UIListLayout", Tab["16"]);
					Tab["1f"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Right;
					Tab["1f"]["Padding"] = UDim.new(0, 5);
					Tab["1f"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

				end
				-- Logic
				do
					function Tab:Deactivate()
						if Tab.Active then
							Tab.Active = false
							Tab.Hover = false
							Tween(Tab["a"], {TextColor3 =Color3.fromRGB(101, 101, 101)}, 0.8)
							Tween(Tab["b"], {Size = UDim2.new(0, 0, 0, 0)}, 0.4)
							Tab["16"].Visible = false
							Tab["15"].Visible = false
						end
					end

					function Tab:Activate()
						if not Tab.Active then
							if UI.CurrentTab ~= nil then
								UI.CurrentTab:Deactivate()
							end
							Tab.Active = true
							Tween(Tab["a"], {TextColor3 =Color3.fromRGB(255, 255, 255)}, 0.8)
							Tween(Tab["b"], {Size = UDim2.new(0, 7, 1, 0)}, 0.8)
							Tab["16"].Visible = true
							Tab["15"].Visible = true
							UI.CurrentTab = Tab
						end
					end

					Tab["a"].MouseEnter:Connect(function()
						Tab.Hover = true
						if not Tab.Active then
							Tween(Tab["a"], {TextColor3 =Color3.fromRGB(200, 200, 200)}, 0.8)
							Tween(Tab["b"], {Size = UDim2.new(0, 7, 0.3, 0)}, 0.8)
						end
					end)

					Tab["a"].MouseLeave:Connect(function()
						Tab.Hover = false
						if not Tab.Active then
							Tween(Tab["a"], {TextColor3 =Color3.fromRGB(101, 101, 101)}, 0.8)
							Tween(Tab["b"], {Size = UDim2.new(0, 0, 0, 0)}, 0.4)
						end
					end)

					UIS.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 and Tab.Hover or Enum.UserInputType.Touch and Tab.Hover then
							Tab:Activate()
						end
					end)

					if UI.CurrentTab == nil then
						Tab:Activate()
					end
				end
				-- Tab Elements
				do
					-- Button
					function Tab:Button(options)
						options = ValidateS({
							Title = "Preview Button",
							Callback = function() print("Clicked") end
						}, options or {})

						local Button = {
							Hover = false,
							MouseDown = false
						}

						-- Rendering
						do
							-- StarterGui.bombaclat.UI.MainArea.Tab.Button
							Button["20"] = Instance.new("TextLabel", Tab["16"]);
							Button["20"]["BorderSizePixel"] = 0;
							Button["20"]["TextXAlignment"] = Enum.TextXAlignment.Left;
							Button["20"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
							Button["20"]["TextSize"] = 12;
							Button["20"]["FontFace"] = Font.new([[rbxasset://fonts/families/Roboto.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
							Button["20"]["TextColor3"] = Color3.fromRGB(200, 200, 200);
							Button["20"]["BackgroundTransparency"] = 1;
							Button["20"]["AnchorPoint"] = Vector2.new(1, 0);
							Button["20"]["Size"] = UDim2.new(1, -20, 0, 30);
							Button["20"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
							Button["20"]["Text"] = options["Title"];
							Button["20"]["Name"] = [[Button]];
							Button["20"]["Position"] = UDim2.new(1, 0, 0, 0);


							-- StarterGui.bombaclat.UI.MainArea.Tab.Button.IconHolder
							Button["21"] = Instance.new("Frame", Button["20"]);
							Button["21"]["BorderSizePixel"] = 0;
							Button["21"]["BackgroundColor3"] = Color3.fromRGB(19, 19, 19);
							Button["21"]["AnchorPoint"] = Vector2.new(1, 0.5);
							Button["21"]["Size"] = UDim2.new(0, 20, 0, 20);
							Button["21"]["Position"] = UDim2.new(1, 0, 0.5, 0);
							Button["21"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
							Button["21"]["Name"] = [[IconHolder]];
							Button["21"]["BackgroundTransparency"] = 1;


							-- StarterGui.bombaclat.UI.MainArea.Tab.Button.IconHolder.UICorner
							Button["22"] = Instance.new("UICorner", Button["21"]);
							Button["22"]["CornerRadius"] = UDim.new(0, 4);


							-- StarterGui.bombaclat.UI.MainArea.Tab.Button.IconHolder.Button
							Button["23"] = Instance.new("ImageLabel", Button["21"]);
							Button["23"]["Image"] = [[rbxassetid://14951952226]];
							Button["23"]["Size"] = UDim2.new(1, 0, 1, 0);
							Button["23"]["BackgroundTransparency"] = 1;
							Button["23"]["Name"] = [[Button]];
							Button["23"]["Position"] = UDim2.new(0, -2, 0, 0);
						end
						-- Logic
						do
							Button["20"].InputBegan:Connect(function()
								Button.Hover = true
								if not Button.MouseDown then
									Tween(Button["20"], {TextColor3 = Color3.fromRGB(230, 230, 230)}, 0.4)
								end
							end)

							Button["20"].InputEnded:Connect(function()
								Button.Hover = false
								if not Button.MouseDown then
									Tween(Button["20"], {TextColor3 = Color3.fromRGB(200, 200, 200)}, 0.4)
								end
							end)

							UIS.InputBegan:Connect(function(input)
								if input.UserInputType == Enum.UserInputType.MouseButton1 and Button.Hover or Enum.UserInputType.Touch and Button.Hover then
									Button.MouseDown = true
									Tween(Button["20"], {TextColor3 = Color3.fromRGB(255, 255, 255)}, 0.4)
									options.Callback()
								end
							end)

							UIS.InputEnded:Connect(function(input)
								if input.UserInputType == Enum.UserInputType.MouseButton1 or Enum.UserInputType.Touch then
									Button.MouseDown = false
									if Button.Hover then
										Tween(Button["20"], {TextColor3 = Color3.fromRGB(230, 230, 230)}, 0.4)
									else
										Tween(Button["20"], {TextColor3 = Color3.fromRGB(200, 200, 200)}, 0.4)
									end
								end
							end)
						end
						return Button	
					end
					-- Toggle
					function Tab:Toggle(options)
						options = ValidateS({
							Title = "Preview Toggle",
							Callback = function(v) print(v) end
						}, options or {})

						local Toggle = {
							Hover = false,
							MouseDown = false,
							State = false
						}

						-- Rendering
						do
							-- StarterGui.bombaclat.UI.MainArea.Tab.Toggle
							Toggle["1b"] = Instance.new("TextLabel", Tab["16"]);
							Toggle["1b"]["BorderSizePixel"] = 0;
							Toggle["1b"]["TextXAlignment"] = Enum.TextXAlignment.Left;
							Toggle["1b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
							Toggle["1b"]["TextSize"] = 12;
							Toggle["1b"]["FontFace"] = Font.new([[rbxasset://fonts/families/Roboto.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
							Toggle["1b"]["TextColor3"] = Color3.fromRGB(200, 200, 200);
							Toggle["1b"]["BackgroundTransparency"] = 1;
							Toggle["1b"]["AnchorPoint"] = Vector2.new(1, 0);
							Toggle["1b"]["Size"] = UDim2.new(1, -20, 0, 30);
							Toggle["1b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
							Toggle["1b"]["Text"] = options["Title"];
							Toggle["1b"]["Name"] = [[Toggle]];
							Toggle["1b"]["Position"] = UDim2.new(1, 0, 0, 0);


							-- StarterGui.bombaclat.UI.MainArea.Tab.Toggle.Check
							Toggle["1c"] = Instance.new("Frame", Toggle["1b"]);
							Toggle["1c"]["BorderSizePixel"] = 0;
							Toggle["1c"]["BackgroundColor3"] = Color3.fromRGB(19, 19, 19);
							Toggle["1c"]["AnchorPoint"] = Vector2.new(1, 0.5);
							Toggle["1c"]["Size"] = UDim2.new(0, 15, 0, 15);
							Toggle["1c"]["Position"] = UDim2.new(1, -5, 0.5, 0);
							Toggle["1c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
							Toggle["1c"]["Name"] = [[Check]];


							-- StarterGui.bombaclat.UI.MainArea.Tab.Toggle.Check.UICorner
							Toggle["1d"] = Instance.new("UICorner", Toggle["1c"]);
							Toggle["1d"]["CornerRadius"] = UDim.new(0, 4);


							-- StarterGui.bombaclat.UI.MainArea.Tab.Toggle.Check.check
							Toggle["1e"] = Instance.new("ImageLabel", Toggle["1c"]);
							Toggle["1e"]["ImageColor3"] = Color3.fromRGB(19, 19, 19);
							Toggle["1e"]["Image"] = [[rbxassetid://14950021853]];
							Toggle["1e"]["Size"] = UDim2.new(1, 0, 1, 0);
							Toggle["1e"]["BackgroundTransparency"] = 1;
							Toggle["1e"]["ImageTransparency"] = 1;
							Toggle["1e"]["Name"] = [[check]];
						end
						-- Logic	
						do
							function Toggle:ChangeState_(Bool)
								if Bool == nil then
									Toggle.State = not Toggle.State
								else
									Toggle.State = Bool
								end

								if Toggle.State then
									Tween(Toggle["1c"], {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}, 0.4)
									Tween(Toggle["1e"], {ImageTransparency = 0}, 0.4)
								else
									Tween(Toggle["1c"], {BackgroundColor3 = Color3.fromRGB(19, 19, 19)}, 0.4)
									Tween(Toggle["1e"], {ImageTransparency = 1}, 0.4)
								end
								options.Callback(Toggle.State)	
							end

							Toggle["1b"].InputBegan:Connect(function()
								Toggle.Hover = true

								if not Toggle.MouseDown then
									Tween(Toggle["1b"], {TextColor3 = Color3.fromRGB(230, 230, 230)}, 0.4)
								end
							end)

							Toggle["1b"].InputEnded:Connect(function()
								Toggle.Hover = false

								if not Toggle.MouseDown then
									Tween(Toggle["1b"], {TextColor3 = Color3.fromRGB(200, 200, 200)}, 0.4)
								end
							end)

							UIS.InputBegan:Connect(function(input)
								if input.UserInputType == Enum.UserInputType.MouseButton1 and Toggle.Hover or Enum.UserInputType.Touch and Toggle.Hover then
									Toggle.MouseDown = true
									Toggle:ChangeState_()
								end
							end)

							UIS.InputEnded:Connect(function(input)
								if input.UserInputType == Enum.UserInputType.MouseButton1 or Enum.UserInputType.Touch then
									Toggle.MouseDown = false
									if Toggle.Hover then
										Tween(Toggle["1b"], {TextColor3 = Color3.fromRGB(230, 230, 230)}, 0.4)
									else
										Tween(Toggle["1b"], {TextColor3 = Color3.fromRGB(200, 200, 200)}, 0.4)
									end
								end
							end)
						end
						return Toggle	
					end
					-- Slider
					function Tab:Slider(options)
						options = ValidateS({
							Title = "Preview Slider",
							Min = 0,
							Max = 100,
							Default = 50,
							Callback = function(v) print(v) end
						}, options or {})

						local Slider = {
							MouseDown = false,
							Hover = false,
							Connection = nil,
							Options = options
						}

						-- Rendering
						do
							-- StarterGui.bombaclat.UI.MainArea.Tab.Slider
							Slider["24"] = Instance.new("TextLabel", Tab["16"]);
							Slider["24"]["BorderSizePixel"] = 0;
							Slider["24"]["TextXAlignment"] = Enum.TextXAlignment.Left;
							Slider["24"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
							Slider["24"]["TextSize"] = 12;
							Slider["24"]["FontFace"] = Font.new([[rbxasset://fonts/families/Roboto.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
							Slider["24"]["TextColor3"] = Color3.fromRGB(200, 200, 200);
							Slider["24"]["BackgroundTransparency"] = 1;
							Slider["24"]["AnchorPoint"] = Vector2.new(1, 0);
							Slider["24"]["Size"] = UDim2.new(1, -20, 0, 40);
							Slider["24"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
							Slider["24"]["Text"] = options["Title"];
							Slider["24"]["Name"] = [[Slider]];
							Slider["24"]["Position"] = UDim2.new(1, 0, 0, 0);


							-- StarterGui.bombaclat.UI.MainArea.Tab.Slider.IconHolder
							Slider["25"] = Instance.new("Frame", Slider["24"]);
							Slider["25"]["BorderSizePixel"] = 0;
							Slider["25"]["BackgroundColor3"] = Color3.fromRGB(19, 19, 19);
							Slider["25"]["AnchorPoint"] = Vector2.new(1, 0.5);
							Slider["25"]["Size"] = UDim2.new(0, 20, 0, 20);
							Slider["25"]["Position"] = UDim2.new(1, 0, 0.5, 0);
							Slider["25"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
							Slider["25"]["Name"] = [[IconHolder]];
							Slider["25"]["BackgroundTransparency"] = 1;


							-- StarterGui.bombaclat.UI.MainArea.Tab.Slider.IconHolder.UICorner
							Slider["26"] = Instance.new("UICorner", Slider["25"]);
							Slider["26"]["CornerRadius"] = UDim.new(0, 4);


							-- StarterGui.bombaclat.UI.MainArea.Tab.Slider.IconHolder.Value
							Slider["27"] = Instance.new("TextLabel", Slider["25"]);
							Slider["27"]["TextSize"] = 10;
							Slider["27"]["FontFace"] = Font.new([[rbxasset://fonts/families/Roboto.json]], Enum.FontWeight.Medium, Enum.FontStyle.Normal);
							Slider["27"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
							Slider["27"]["BackgroundTransparency"] = 1;
							Slider["27"]["Size"] = UDim2.new(1, 0, 1, 0);
							Slider["27"]["Text"] = [[50]];
							Slider["27"]["Name"] = [[Value]];
							Slider["27"]["Position"] = UDim2.new(0, -2, 0, 2);


							-- StarterGui.bombaclat.UI.MainArea.Tab.Slider.UIPadding
							Slider["28"] = Instance.new("UIPadding", Slider["24"]);
							Slider["28"]["PaddingBottom"] = UDim.new(0, 10);


							-- StarterGui.bombaclat.UI.MainArea.Tab.Slider.SliderBG
							Slider["29"] = Instance.new("Frame", Slider["24"]);
							Slider["29"]["BorderSizePixel"] = 0;
							Slider["29"]["BackgroundColor3"] = Color3.fromRGB(19, 19, 19);
							Slider["29"]["AnchorPoint"] = Vector2.new(0, 1);
							Slider["29"]["Size"] = UDim2.new(1, -5, 0, 4);
							Slider["29"]["Position"] = UDim2.new(0, 0, 1, 5);
							Slider["29"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
							Slider["29"]["Name"] = [[SliderBG]];



							-- StarterGui.bombaclat.UI.MainArea.Tab.Slider.SliderBG.UICorner
							Slider["2a"] = Instance.new("UICorner", Slider["29"]);
							Slider["2a"]["CornerRadius"] = UDim.new(0, 12);


							-- StarterGui.bombaclat.UI.MainArea.Tab.Slider.SliderBG.Drag
							Slider["2b"] = Instance.new("Frame", Slider["29"]);
							Slider["2b"]["BorderSizePixel"] = 0;
							Slider["2b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
							Slider["2b"]["Size"] = UDim2.new(0.5, 0, 1, 0);
							Slider["2b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
							Slider["2b"]["Name"] = [[Drag]];


							-- StarterGui.bombaclat.UI.MainArea.Tab.Slider.SliderBG.Drag.UICorner
							Slider["2c"] = Instance.new("UICorner", Slider["2b"]);
							Slider["2c"]["CornerRadius"] = UDim.new(0, 12);
						end
						-- Logic
						do
							function Slider:SetValue(v)
								if v == nil then
									local percentage = math.clamp((mouse.X - Slider["29"].AbsolutePosition.X) / (Slider["29"].AbsoluteSize.X), 0, 1)
									local value = math.floor(((options.Max - options.Min) * percentage) + options.Min)
									Slider["27"].Text = tostring(value)
									Slider["2b"].Size = UDim2.fromScale(percentage, 1)
								else
									Slider["27"].Text = tostring(v)
									Slider["2b"].Size = UDim2.fromScale(((v - options.Min) / (options.Max - options.Min)), 1)
								end
								options.Callback(Slider:GetValue())
							end

							function Slider:GetValue()
								return tonumber(Slider["27"].Text)				
							end

							Slider["24"].MouseEnter:Connect(function()
								Slider.Hover = true

								if not Slider.MouseDown then
									Tween(Slider["24"], {TextColor3 = Color3.fromRGB(230, 230, 230)}, 0.5)
								end
							end)

							Slider["24"].MouseLeave:Connect(function()
								Slider.Hover = false

								if not Slider.MouseDown then
									Tween(Slider["24"], {TextColor3 = Color3.fromRGB(200, 200, 200)}, 0.5)
								end
							end)

							UIS.InputBegan:Connect(function(input)
								if input.UserInputType == Enum.UserInputType.MouseButton1 and Slider.Hover or Enum.UserInputType.Touch and Slider.Hover then
									stop = true
									Slider.MouseDown = true
									Tween(Slider["24"], {TextColor3 = Color3.fromRGB(255, 255, 255)}, 0.5)

									if not Slider.Connection then
										Slider.Connection = runService.RenderStepped:Connect(function()
											Slider:SetValue()
										end)
									end
								end
							end)

							UIS.InputEnded:Connect(function(input)
								if input.UserInputType == Enum.UserInputType.MouseButton1 or Enum.UserInputType.Touch then
									stop = false
									Slider.MouseDown = false

									if Slider.Hover then
										Tween(Slider["24"], {TextColor3 = Color3.fromRGB(230, 230, 230)}, 0.5)
									else
										Tween(Slider["24"], {TextColor3 = Color3.fromRGB(200, 200, 200)}, 0.5)
									end

									if Slider.Connection then Slider.Connection:Disconnect() end
									Slider.Connection = nil
								end
							end)
						end
						return Slider
					end
					-- Dropdown	
					function Tab:Dropdown(options)
						options = ValidateS({
							Title = "Preview Dropdown",
							Selectmode = false,
							Items = {}
						}, options or {})

						local Dropdown = {
							Items = {
								["id"] = { 
									"value"
								}
							},
							Open = false,
							MouseDown = false,
							Hover = false,
							HoveringItem = false,
							SelectedItems = {}
						}

						-- Rendering
						do
							-- StarterGui.bombaclat.UI.MainArea.Tab.Dropdown
							Dropdown["3e"] = Instance.new("TextLabel", Tab["16"]);
							Dropdown["3e"]["BorderSizePixel"] = 0;
							Dropdown["3e"]["TextXAlignment"] = Enum.TextXAlignment.Left;
							Dropdown["3e"]["TextYAlignment"] = Enum.TextYAlignment.Top;
							Dropdown["3e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
							Dropdown["3e"]["TextSize"] = 12;
							Dropdown["3e"]["FontFace"] = Font.new([[rbxasset://fonts/families/Roboto.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
							Dropdown["3e"]["TextColor3"] = Color3.fromRGB(200, 200, 200);
							Dropdown["3e"]["BackgroundTransparency"] = 1;
							Dropdown["3e"]["AnchorPoint"] = Vector2.new(1, 0);
							Dropdown["3e"]["Size"] = UDim2.new(1, -20, 0, 30);
							Dropdown["3e"]["ClipsDescendants"] = true;
							Dropdown["3e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
							Dropdown["3e"]["Text"] = options["Title"];
							Dropdown["3e"]["Name"] = [[Dropdown]];
							Dropdown["3e"]["Position"] = UDim2.new(1, 0, 0, 0);


							-- StarterGui.bombaclat.UI.MainArea.Tab.Dropdown.IconHolder
							Dropdown["3f"] = Instance.new("Frame", Dropdown["3e"]);
							Dropdown["3f"]["BorderSizePixel"] = 0;
							Dropdown["3f"]["BackgroundColor3"] = Color3.fromRGB(19, 19, 19);
							Dropdown["3f"]["AnchorPoint"] = Vector2.new(1, 0);
							Dropdown["3f"]["Size"] = UDim2.new(0, 20, 0, 20);
							Dropdown["3f"]["Position"] = UDim2.new(1, 0, 0, -3);
							Dropdown["3f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
							Dropdown["3f"]["Name"] = [[IconHolder]];
							Dropdown["3f"]["BackgroundTransparency"] = 1;


							-- StarterGui.bombaclat.UI.MainArea.Tab.Dropdown.IconHolder.UICorner
							Dropdown["40"] = Instance.new("UICorner", Dropdown["3f"]);
							Dropdown["40"]["CornerRadius"] = UDim.new(0, 4);


							-- StarterGui.bombaclat.UI.MainArea.Tab.Dropdown.IconHolder.Value
							Dropdown["41"] = Instance.new("ImageLabel", Dropdown["3f"]);
							Dropdown["41"]["Image"] = [[rbxassetid://14951833548]];
							Dropdown["41"]["Size"] = UDim2.new(1, 0, 1, 0);
							Dropdown["41"]["BackgroundTransparency"] = 1;
							Dropdown["41"]["Name"] = [[Value]];
							Dropdown["41"]["Position"] = UDim2.new(0, -2, 0, 0);


							-- StarterGui.bombaclat.UI.MainArea.Tab.Dropdown.UIPadding
							Dropdown["42"] = Instance.new("UIPadding", Dropdown["3e"]);
							Dropdown["42"]["PaddingTop"] = UDim.new(0, 5);


							-- StarterGui.bombaclat.UI.MainArea.Tab.Dropdown.DropdownItems
							Dropdown["43"] = Instance.new("ScrollingFrame", Dropdown["3e"]);
							Dropdown["43"]["Visible"] = false;
							Dropdown["43"]["Active"] = true;
							Dropdown["43"]["BorderSizePixel"] = 0;
							Dropdown["43"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
							Dropdown["43"]["Name"] = [[DropdownItems]];
							Dropdown["43"]["Size"] = UDim2.new(1, -5, 1, -22);
							Dropdown["43"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
							Dropdown["43"]["Position"] = UDim2.new(0, 0, 0, 17);
							Dropdown["43"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
							Dropdown["43"]["ScrollBarThickness"] = 0;
							Dropdown["43"]["BackgroundTransparency"] = 1;


							-- StarterGui.bombaclat.UI.MainArea.Tab.Dropdown.DropdownItems.UICorner
							Dropdown["44"] = Instance.new("UICorner", Dropdown["43"]);
							Dropdown["44"]["CornerRadius"] = UDim.new(0, 4);

							-- StarterGui.bombaclat.UI.MainArea.Tab.Dropdown.DropdownItems.UIListLayout
							Dropdown["48"] = Instance.new("UIListLayout", Dropdown["43"]);
							Dropdown["48"]["Padding"] = UDim.new(0, 5);
							Dropdown["48"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
						end
						-- Logic
						do
							function Dropdown:Add(Id, Title, Callback)
								Callback = Callback or function() end
								local Item = {
									Hover = false,
									MouseDown = false,
									Selected = false
								}

								if Dropdown.Items[Id] ~= nil then
									return
								end

								Dropdown.Items[Id] = {
									instance = {},
									value = Title
								}
								
								-- Rendering
								do
									-- StarterGui.bombaclat.UI.MainArea.Tab.Dropdown.DropdownItems.Item
									Dropdown.Items[Id].instance["49"] = Instance.new("TextLabel", Dropdown["43"]);
									Dropdown.Items[Id].instance["49"]["BorderSizePixel"] = 0;
									Dropdown.Items[Id].instance["49"]["TextXAlignment"] = Enum.TextXAlignment.Left;
									Dropdown.Items[Id].instance["49"]["BackgroundColor3"] = Color3.fromRGB(19, 19, 19);
									Dropdown.Items[Id].instance["49"]["TextSize"] = 10;
									Dropdown.Items[Id].instance["49"]["FontFace"] = Font.new([[rbxasset://fonts/families/Roboto.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
									Dropdown.Items[Id].instance["49"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
									Dropdown.Items[Id].instance["49"]["Size"] = UDim2.new(1, 0, 0, 20);
									Dropdown.Items[Id].instance["49"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
									Dropdown.Items[Id].instance["49"]["Text"] = Title;
									Dropdown.Items[Id].instance["49"]["Name"] = [[Item]];

									-- StarterGui.bombaclat.UI.MainArea.Tab.Dropdown.DropdownItems.Item.UICorner
									Dropdown.Items[Id].instance["4a"] = Instance.new("UICorner", Dropdown.Items[Id].instance["49"]);
									Dropdown.Items[Id].instance["4a"]["CornerRadius"] = UDim.new(0, 4);
									
									-- StarterGui.bombaclat.UI.MainArea.Tab.Dropdown.DropdownItems.Item.UIPadding
									Dropdown.Items[Id].instance["4b"] = Instance.new("UIPadding", Dropdown.Items[Id].instance["49"]);
									Dropdown.Items[Id].instance["4b"]["PaddingLeft"] = UDim.new(0, 5);
								end
								-- Logic
								do
									local function UpdateItemAppearance()
										if Item.Selected then
											Tween(Dropdown.Items[Id].instance["49"], {BackgroundColor3 = Color3.fromRGB(120, 120, 120)}, 0.2)
										else
											Tween(Dropdown.Items[Id].instance["49"], {BackgroundColor3 = Color3.fromRGB(19, 19, 19)}, 0.2)
										end
									end
									
									Dropdown.Items[Id].instance["49"].MouseEnter:Connect(function()
										Item.Hover = true
										Dropdown.HoveringItem = true
										if not Item.MouseDown and not Item.Selected then
											Tween(Dropdown.Items[Id].instance["49"], {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}, 0.2)
										end
									end)

									Dropdown.Items[Id].instance["49"].MouseLeave:Connect(function()
										Item.Hover = false
										Dropdown.HoveringItem = false

										if not Item.MouseDown and not Item.Selected then
											Tween(Dropdown.Items[Id].instance["49"], {BackgroundColor3 = Color3.fromRGB(19, 19, 19)}, 0.2)
										end
									end)

									UIS.InputBegan:Connect(function(input)
										if Dropdown.Items[Id] == nil then return end

										if input.UserInputType == Enum.UserInputType.MouseButton1 and Item.Hover or input.UserInputType == Enum.UserInputType.Touch and Item.Hover then
											Item.MouseDown = true

											if options.Selectmode then
												Item.Selected = not Item.Selected
												if Item.Selected then
													Dropdown.SelectedItems[Id] = Title
												else
													Dropdown.SelectedItems[Id] = nil
												end
												Tween(Dropdown.Items[Id].instance["49"], {BackgroundColor3 = Item.Selected and Color3.fromRGB(80, 80, 80) or Color3.fromRGB(19, 19, 19)}, 0.2)
											else
												for i, v in pairs(Dropdown.Items) do
													if v.instance then
														v.instance["49"].BackgroundColor3 = Color3.fromRGB(19, 19, 19)
													end
												end
												Tween(Dropdown.Items[Id].instance["49"], {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}, 0.2)
												Dropdown.SelectedItems = { [Id] = Title }
												Dropdown:Toggle()
											end
											Callback(Id)
										end
									end)

									UIS.InputEnded:Connect(function(input)
										if Dropdown.Items[Id] == nil then return end

										if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
											Item.MouseDown = false
											UpdateItemAppearance()
										end
									end)
								end
							end
							
							function Dropdown:GetSelectedItems()
								local selectedText = ""

								for id, title in pairs(Dropdown.SelectedItems) do
									if title then
										selectedText = selectedText .. title .. ", "
									end
								end

								if selectedText == "" then
									return "No items selected"
								else
									return selectedText:sub(1, -3)
								end
							end
							
							function Dropdown:Remove(id)
								if Dropdown.Items[id] ~= nil then
									if Dropdown.Items[id].instance ~= nil then
										for i, v in pairs(Dropdown.Items[id].instance) do
											v:Destroy()
										end
									end
									Dropdown.Items[id] = nil
								end
							end
							
							function Dropdown:Clear()
								for i, v in pairs(Dropdown.Items) do
									Dropdown:Remove(i)
								end
							end

							function Dropdown:Toggle()
								Dropdown.Open = not Dropdown.Open

								if not Dropdown.Open and not Dropdown.HoveringItem then
									Tween(Dropdown["3e"], {Size = UDim2.new(1, -20,0, 30)}, 0.2, function()
										Dropdown["43"].Visible = false
									end)
								else
									local count = 0
									for i, v in pairs(Dropdown.Items) do
										if v ~= nil then
											count += 1
										end
									end

									Dropdown["43"].Visible = true
									Tween(Dropdown["3e"], {Size = UDim2.new(1, -20, 0, 17 + (count * 26) + 1)}, 0.2)
								end
							end
							
							Dropdown["3e"].MouseEnter:Connect(function()
								Dropdown.Hover = true
								Tween(Dropdown["3e"], {TextColor3 = Color3.fromRGB(230, 230, 230)}, 0.2)
							end)

							Dropdown["3e"].MouseLeave:Connect(function()
								Dropdown.Hover = false
								if not Dropdown.MouseDown then
									Tween(Dropdown["3e"], {TextColor3 = Color3.fromRGB(200, 200, 200)}, 0.2)
								end
							end)

							UIS.InputBegan:Connect(function(input)
								if input.UserInputType == Enum.UserInputType.MouseButton1 and Dropdown.Hover or Enum.UserInputType.Touch and Dropdown.Hover then
									Dropdown.MouseDown = true
									Tween(Dropdown["3e"], {TextColor3 = Color3.fromRGB(255, 255 ,255)}, 0.2)
									if not Dropdown.HoveringItem then
										Dropdown:Toggle()
									end
								end
							end)

							UIS.InputEnded:Connect(function(input)
								if input.UserInputType == Enum.UserInputType.MouseButton1 or Enum.UserInputType.Touch then
									Dropdown.MouseDown = false
									if Dropdown.Hover then
										Tween(Dropdown["3e"], {TextColor3 = Color3.fromRGB(230, 230, 230)}, 0.2)
									else
										Tween(Dropdown["3e"], {TextColor3 = Color3.fromRGB(200, 200, 200)}, 0.2)
									end
								end
							end)	
						end						
						return Dropdown	
					end
				end
				return Tab	
			end
		end
		-- Logic
		do
			local function Cursor(frame, rbxassetid)
				if not frame or not rbxassetid then
					warn("Invalid parameters. Please provide a valid frame and rbxassetid.")
					return
				end

				local customCursor = Instance.new("ImageLabel")
				customCursor.Name = "CustomCursor"
				customCursor.Size = UDim2.new(0, 20, 0, 20)
				customCursor.Position = UDim2.new(0, 0, 0, 0)
				customCursor.BackgroundTransparency = 1
				customCursor.Image = "rbxassetid://" .. rbxassetid
				customCursor.Parent = frame

				local function onRenderStep()
					local mouse = game.Players.LocalPlayer:GetMouse()
					local mouseX = mouse.X
					local mouseY = mouse.Y
					local framePosition = frame.AbsolutePosition
					local frameSize = frame.AbsoluteSize

					if mouseX >= framePosition.X and mouseX <= framePosition.X + frameSize.X and
						mouseY >= framePosition.Y and mouseY <= framePosition.Y + frameSize.Y then
						customCursor.Position = UDim2.new(0, mouseX - framePosition.X - (customCursor.Size.X.Offset / 2), 0, mouseY - framePosition.Y - (customCursor.Size.Y.Offset / 2) + 5)
						customCursor.Visible = true
						UIS.MouseIconEnabled = false
					else
						customCursor.Visible = false
						UIS.MouseIconEnabled = true
					end
				end
				runService.RenderStepped:Connect(onRenderStep)
			end	
			-- Exit
			do
				UI["65"].MouseEnter:Connect(function()
					UI.ExitHover = true
				end)

				UI["65"].MouseLeave:Connect(function()
					UI.ExitHover = false
				end)

				UIS.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 and UI.ExitHover or Enum.UserInputType.Touch and UI.ExitHover then
						for i, v in UI["2"]:GetDescendants() do
							if v:IsA("ImageLabel") then
								Tween(v, {ImageTransparency = 1}, 1)
								Tween(v, {BackgroundTransparency = 1}, 1)
							elseif v:IsA("TextLabel") then
								Tween(v, {TextTransparency = 1}, 1)
								Tween(v, {BackgroundTransparency = 1}, 1)
							elseif v:IsA("Frame") then
								Tween(v, {BackgroundTransparency = 1}, 1)
							end
						end
						Tween(UI["2"], {Size = UDim2.new(0, 0, 0, 0)}, 2, function() 
							UI["2"]:Destroy()
							for i, v in UI["61"]:GetDescendants() do
								if v:IsA("ImageLabel") then
									Tween(v, {ImageTransparency = 1}, 1)
									Tween(v, {BackgroundTransparency = 1}, 1, function() 
										Tween(UI["61"], {Size = UDim2.new(0, 105, 0, 0)}, 2, function() 
											wait(2)
											UI["1"]:Destroy()
										end)
									end)
								end
							end
						end)
					end
				end)
			end
			-- Maximize
			do
				UI["66"].MouseEnter:Connect(function()
					UI.MaximizeHover = true
				end)

				UI["66"].MouseLeave:Connect(function()
					UI.MaximizeHover = false
				end)

				UIS.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 and UI.MaximizeHover or Enum.UserInputType.Touch and UI.MaximizeHover then
						Tween(UI["2"], {Size = UDim2.new(1, 0, 1, 0)}, 0.2)
						Tween(UI["2"], {Position = UDim2.new(0.5, 0, 0.5, 0)}, 0.2)
						stopforce = true
					end
				end)
			end
			-- Minimize
			do
				UI["67"].MouseEnter:Connect(function()
					UI.MinimizeHover = true
				end)

				UI["67"].MouseLeave:Connect(function()
					UI.MinimizeHover= false
				end)

				UIS.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 and UI.MinimizeHover or Enum.UserInputType.Touch and UI.MinimizeHover then
						Tween(UI["2"], {Size = UISIZE}, 0.8)
						stopforce = false
					end
				end)
			end
			-- Socials
			do
				UI["69"].MouseEnter:Connect(function()
					UI.DiscordHover = true
				end)
				
				UI["69"].MouseLeave:Connect(function()
					UI.DiscordHover = false
				end)
				
				UI["68"].MouseEnter:Connect(function()
					UI.YoutubeHover = true
				end)

				UI["68"].MouseLeave:Connect(function()
					UI.YoutubeHover = false
				end)
				
				UIS.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 and UI.DiscordHover then
						setclipboard(options["Discord"])
					end
				end)
				
				UIS.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 and UI.YoutubeHover then
						setclipboard(options["Youtube"])
					end
				end)
			end
			Cursor(UI["2"], 83884515509675)
			NOTSTOLENDRAG(UI["2"])
		end
		return UI
	end

	function Notify:Warning(options)
		local options = ValidateS({
			Title = "Warning",
			Desc = "Example Warning"
		}, options or {})

		local WarningUI = {}

		-- Rendering
		do
			-- StarterGui.bombaclat.Notifs Holder.Notif
			WarningUI["50"] = Instance.new("Frame", UI["4f"]);
			WarningUI["50"]["BorderSizePixel"] = 0;
			WarningUI["50"]["BackgroundColor3"] = Color3.fromRGB(13, 13, 13);
			WarningUI["50"]["Size"] = UDim2.new(1, 0, 0, 60);
			WarningUI["50"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			WarningUI["50"]["Name"] = [[Notif]];

			-- StarterGui.bombaclat.Notifs Holder.Notif.UICorner
			WarningUI["51"] = Instance.new("UICorner", WarningUI["50"]);
			WarningUI["51"]["CornerRadius"] = UDim.new(0, 6);


			-- StarterGui.bombaclat.Notifs Holder.Notif.DropShadowHolder
			WarningUI["52"] = Instance.new("Frame", WarningUI["50"]);
			WarningUI["52"]["ZIndex"] = 0;
			WarningUI["52"]["BorderSizePixel"] = 0;
			WarningUI["52"]["Size"] = UDim2.new(1, 0, 1, 0);
			WarningUI["52"]["Name"] = [[DropShadowHolder]];
			WarningUI["52"]["BackgroundTransparency"] = 1;


			-- StarterGui.bombaclat.Notifs Holder.Notif.DropShadowHolder.DropShadow
			WarningUI["53"] = Instance.new("ImageLabel", WarningUI["52"]);
			WarningUI["53"]["ZIndex"] = 0;
			WarningUI["53"]["BorderSizePixel"] = 0;
			WarningUI["53"]["SliceCenter"] = Rect.new(49, 49, 450, 450);
			WarningUI["53"]["ScaleType"] = Enum.ScaleType.Slice;
			WarningUI["53"]["ImageTransparency"] = 0.5;
			WarningUI["53"]["ImageColor3"] = Color3.fromRGB(0, 0, 0);
			WarningUI["53"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
			WarningUI["53"]["Image"] = [[rbxassetid://6014261993]];
			WarningUI["53"]["Size"] = UDim2.new(1, 47, 1, 47);
			WarningUI["53"]["BackgroundTransparency"] = 1;
			WarningUI["53"]["Name"] = [[DropShadow]];
			WarningUI["53"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


			-- StarterGui.bombaclat.Notifs Holder.Notif.NotifType
			WarningUI["54"] = Instance.new("TextLabel", WarningUI["50"]);
			WarningUI["54"]["BorderSizePixel"] = 0;
			WarningUI["54"]["TextXAlignment"] = Enum.TextXAlignment.Left;
			WarningUI["54"]["TextYAlignment"] = Enum.TextYAlignment.Top;
			WarningUI["54"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			WarningUI["54"]["TextSize"] = 14;
			WarningUI["54"]["FontFace"] = Font.new([[rbxasset://fonts/families/Roboto.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
			WarningUI["54"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			WarningUI["54"]["BackgroundTransparency"] = 1;
			WarningUI["54"]["AnchorPoint"] = Vector2.new(1, 0);
			WarningUI["54"]["Size"] = UDim2.new(1, -60, 0, 14);
			WarningUI["54"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			WarningUI["54"]["Text"] = options["Title"];
			WarningUI["54"]["Name"] = [[NotifType]];
			WarningUI["54"]["Position"] = UDim2.new(1, 0, 0, 14);


			-- StarterGui.bombaclat.Notifs Holder.Notif.Desc
			WarningUI["55"] = Instance.new("TextLabel", WarningUI["50"]);
			WarningUI["55"]["BorderSizePixel"] = 0;
			WarningUI["55"]["TextWrapped"] = true;
			WarningUI["55"]["TextXAlignment"] = Enum.TextXAlignment.Left;
			WarningUI["55"]["TextYAlignment"] = Enum.TextYAlignment.Top;
			WarningUI["55"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			WarningUI["55"]["TextSize"] = 9;
			WarningUI["55"]["FontFace"] = Font.new([[rbxasset://fonts/families/Roboto.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
			WarningUI["55"]["TextColor3"] = Color3.fromRGB(81, 81, 81);
			WarningUI["55"]["BackgroundTransparency"] = 1;
			WarningUI["55"]["AnchorPoint"] = Vector2.new(1, 0);
			WarningUI["55"]["Size"] = UDim2.new(1, -60, 0, 28);
			WarningUI["55"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			WarningUI["55"]["Text"] = options["Desc"];
			WarningUI["55"]["Name"] = [[Desc]];
			WarningUI["55"]["Position"] = UDim2.new(1, 1, 0, 33);


			-- StarterGui.bombaclat.Notifs Holder.Notif.warning
			WarningUI["56"] = Instance.new("ImageLabel", WarningUI["50"]);
			WarningUI["56"]["AnchorPoint"] = Vector2.new(0, 0.5);
			WarningUI["56"]["Image"] = [[rbxassetid://14966839736]];
			WarningUI["56"]["Size"] = UDim2.new(0, 32, 0, 32);
			WarningUI["56"]["BackgroundTransparency"] = 1;
			WarningUI["56"]["Name"] = [[warning]];
			WarningUI["56"]["Position"] = UDim2.new(0, 14, 0.5, 0);
		end
		-- Logic
		do
			wait(4)
			for i, v in WarningUI["50"]:GetDescendants() do
				if v:IsA("ImageLabel") then
					Tween(WarningUI["50"], {BackgroundTransparency = 1}, 0.6)
					Tween(v, {ImageTransparency = 1}, 0.6)
				elseif v:IsA("TextLabel") then
					Tween(v, {TextTransparency = 1}, 0.6)
				end
			end
		end
		return WarningUI
	end

	function Notify:Notify(options)
		local options = ValidateS({
			Title = "Notification",
			Desc = "Example Notification"
		}, options or {})

		local NotifUI = {}

		-- Rendering
		do
			-- StarterGui.bombaclat.Notifs Holder.Notif
			NotifUI["59"] = Instance.new("Frame", UI["4f"]);
			NotifUI["59"]["BorderSizePixel"] = 0;
			NotifUI["59"]["BackgroundColor3"] = Color3.fromRGB(13, 13, 13);
			NotifUI["59"]["Size"] = UDim2.new(1, 0, 0, 60);
			NotifUI["59"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			NotifUI["59"]["Name"] = [[Notif]];


			-- StarterGui.bombaclat.Notifs Holder.Notif.UICorner
			NotifUI["5a"] = Instance.new("UICorner", NotifUI["59"]);
			NotifUI["5a"]["CornerRadius"] = UDim.new(0, 6);


			-- StarterGui.bombaclat.Notifs Holder.Notif.DropShadowHolder
			NotifUI["5b"] = Instance.new("Frame", NotifUI["59"]);
			NotifUI["5b"]["ZIndex"] = 0;
			NotifUI["5b"]["BorderSizePixel"] = 0;
			NotifUI["5b"]["Size"] = UDim2.new(1, 0, 1, 0);
			NotifUI["5b"]["Name"] = [[DropShadowHolder]];
			NotifUI["5b"]["BackgroundTransparency"] = 1;


			-- StarterGui.bombaclat.Notifs Holder.Notif.DropShadowHolder.DropShadow
			NotifUI["5c"] = Instance.new("ImageLabel", NotifUI["5b"]);
			NotifUI["5c"]["ZIndex"] = 0;
			NotifUI["5c"]["BorderSizePixel"] = 0;
			NotifUI["5c"]["SliceCenter"] = Rect.new(49, 49, 450, 450);
			NotifUI["5c"]["ScaleType"] = Enum.ScaleType.Slice;
			NotifUI["5c"]["ImageTransparency"] = 0.5;
			NotifUI["5c"]["ImageColor3"] = Color3.fromRGB(0, 0, 0);
			NotifUI["5c"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
			NotifUI["5c"]["Image"] = [[rbxassetid://6014261993]];
			NotifUI["5c"]["Size"] = UDim2.new(1, 47, 1, 47);
			NotifUI["5c"]["BackgroundTransparency"] = 1;
			NotifUI["5c"]["Name"] = [[DropShadow]];
			NotifUI["5c"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);


			-- StarterGui.bombaclat.Notifs Holder.Notif.notifications_active
			NotifUI["5d"] = Instance.new("ImageLabel", NotifUI["59"]);
			NotifUI["5d"]["AnchorPoint"] = Vector2.new(0, 0.5);
			NotifUI["5d"]["Image"] = [[rbxassetid://14957911417]];
			NotifUI["5d"]["Size"] = UDim2.new(0, 32, 0, 32);
			NotifUI["5d"]["BackgroundTransparency"] = 1;
			NotifUI["5d"]["Name"] = [[notifications_active]];
			NotifUI["5d"]["Position"] = UDim2.new(0, 14, 0.5, 0);


			-- StarterGui.bombaclat.Notifs Holder.Notif.NotifType
			NotifUI["5e"] = Instance.new("TextLabel", NotifUI["59"]);
			NotifUI["5e"]["BorderSizePixel"] = 0;
			NotifUI["5e"]["TextXAlignment"] = Enum.TextXAlignment.Left;
			NotifUI["5e"]["TextYAlignment"] = Enum.TextYAlignment.Top;
			NotifUI["5e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			NotifUI["5e"]["TextSize"] = 14;
			NotifUI["5e"]["FontFace"] = Font.new([[rbxasset://fonts/families/Roboto.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
			NotifUI["5e"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
			NotifUI["5e"]["BackgroundTransparency"] = 1;
			NotifUI["5e"]["AnchorPoint"] = Vector2.new(1, 0);
			NotifUI["5e"]["Size"] = UDim2.new(1, -60, 0, 14);
			NotifUI["5e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			NotifUI["5e"]["Text"] = options["Title"];
			NotifUI["5e"]["Name"] = [[NotifType]];
			NotifUI["5e"]["Position"] = UDim2.new(1, 0, 0, 14);


			-- StarterGui.bombaclat.Notifs Holder.Notif.Desc
			NotifUI["5f"] = Instance.new("TextLabel", NotifUI["59"]);
			NotifUI["5f"]["TextWrapped"] = true;
			NotifUI["5f"]["BorderSizePixel"] = 0;
			NotifUI["5f"]["TextXAlignment"] = Enum.TextXAlignment.Left;
			NotifUI["5f"]["TextYAlignment"] = Enum.TextYAlignment.Top;
			NotifUI["5f"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			NotifUI["5f"]["TextSize"] = 9;
			NotifUI["5f"]["FontFace"] = Font.new([[rbxasset://fonts/families/Roboto.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
			NotifUI["5f"]["TextColor3"] = Color3.fromRGB(81, 81, 81);
			NotifUI["5f"]["BackgroundTransparency"] = 1;
			NotifUI["5f"]["AnchorPoint"] = Vector2.new(1, 0);
			NotifUI["5f"]["Size"] = UDim2.new(1, -60, 0, 28);
			NotifUI["5f"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
			NotifUI["5f"]["Text"] = options["Desc"];
			NotifUI["5f"]["Name"] = [[Desc]];
			NotifUI["5f"]["Position"] = UDim2.new(1, 1, 0, 33);


			-- StarterGui.bombaclat.Notifs Holder.Notif.Desc.UIPadding
			NotifUI["60"] = Instance.new("UIPadding", NotifUI["5f"]);
			NotifUI["60"]["PaddingRight"] = UDim.new(0, 5);
			NotifUI["60"]["PaddingBottom"] = UDim.new(0, 5);
		end
		-- Logic
		do
			wait(4)
			for i, v in NotifUI["59"]:GetDescendants() do
				if v:IsA("ImageLabel") then
					Tween(NotifUI["59"], {BackgroundTransparency = 1}, 0.6)
					Tween(v, {ImageTransparency = 1}, 0.6)
				elseif v:IsA("TextLabel") then
					Tween(v, {TextTransparency = 1}, 0.6)
				end
			end
		end
		return NotifUI
	end
end
