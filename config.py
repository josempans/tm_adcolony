def can_build(plat):
    return plat == "iphone"

def configure(env):
    if env['platform'] == "iphone":
        env.Append(FRAMEWORKPATH=['modules/tm_adcolony/ios/lib'])
        env.Append(LINKFLAGS=['-ObjC',
                              '-l', 'z.1.2.5',
                              '-framework', 'AdColony',
                              '-framework', 'AudioToolbox',
                              '-framework', 'AdSupport',
                              '-framework', 'AVFoundation',
                              '-framework', 'CoreTelephony',
                              '-framework', 'EventKit',
                              '-framework', 'MessageUI',
                              '-framework', 'Social',
                              '-framework', 'SystemConfiguration',
                              '-weak_framework', 'JavaScriptCore',
                              '-weak_framework', 'WatchConnectivity',
                              '-weak_framework', 'WebKit'])
