#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// Forçamos o gerenciador de verificação a sempre dizer que o dispositivo está OK
%hook VerificationManager
- (void)validatePayloadWithServer:(int64_t)arg1 {
    NSLog(@"[AscentBypass] Ignorando servidor...");
    return; 
}

- (BOOL)isDeviceVerified {
    return YES;
}

- (BOOL)isLicenseActive {
    return YES;
}
%end

// Bloqueamos o Safari de abrir para o site do "Degolado" não atrapalhar
%hook UIApplication
- (void)openURL:(NSURL*)url options:(NSDictionary<NSString *,id> *)options completionHandler:(void (^)(BOOL success))completion {
    if ([url.absoluteString containsString:@"degolado"]) {
        NSLog(@"[AscentBypass] Safari bloqueado!");
        if (completion) completion(YES);
        return;
    }
    %orig;
}
%end
