//
//  ModuloWindow.swift
//  Modulo
//
//  Created by Theo Sementa on 31/03/2026.
//

import UIKit
import ToastBannerKit

final class ModuloWindow: UIWindow {

    override func sendEvent(_ event: UIEvent) {
        if event.type == .touches,
           let touch = event.allTouches?.first,
           touch.phase == .began {
            if ToastBannerService.shared.toastBanner != nil {
                ToastBannerService.shared.toastBanner = nil
            }
        }
        super.sendEvent(event)
    }

}
