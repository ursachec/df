import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Util.EZConfig(additionalKeys)

main = xmonad =<< myBarConfig myConfig

myConfig = defaultConfig 
    {
     modMask     = myModMask
    , borderWidth = myBorderWidth
    , normalBorderColor = myBorderColor
    , focusedBorderColor = myFocusedBorderColor
    , logHook = dynamicLog
    } `additionalKeys` myAdditionalKeys

myTerminal    = "urxvt"
myModMask     = mod4Mask -- Win key or Super_L
myBorderWidth = 8
myBorderColor = "#666666"
myFocusedBorderColor = "#008800"
myAdditionalKeys =
  [
    ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock; xset dpms force off")
  ]

-- configure xmobar
myBarConfig = statusBar myBar myPP toggleStrutsKey
myBar = "xmobar"
myPP =  xmobarPP { ppCurrent = xmobarColor "#429942" "" . wrap "<" ">" }
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)
