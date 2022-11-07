////
////  SettingViewModel.swift
////  Grind
////
////  Created by 최형민 on 2022/11/01.
////
//
//import Foundation
//import Zip
//
//final class SettingViewModel {
//    
//    func documentDirectoryPath() -> URL? {
//        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil } // Document 경로
//        return documentDirectory
//    }
//    
//    func backupButtonClicked() {
//        
//        var urlPaths = [URL]()
//        
//        // 1. Document 위치 확인을 먼저 한다.
//        // 저장을 해야해서 위치를 알아보는 과정
//        guard let path = documentDirectoryPath() else {
//            print("Document 위치에 오류가 있습니다.")
//            return
//        }
//        
//        // 2. Realm 파일의 경로를 확인한다. document 위치 뒤에 default.realm 붙여서 확인하면 됨
//        // URL 타입
//        let realmFilePath = path.appendingPathComponent("default.realm")
//        
//        // 3. 백업 파일 확인 과정 (Realm 파일 없으면 백업 불가)
//        // 사용자가 어떠한 파일도 저장하지 않은 경우
//        guard FileManager.default.fileExists(atPath: realmFilePath.path) else {
//            print("백업할 파일이 없습니다.")
//            return
//        }
//        
//        // 4. url 기반으로 압축
//        urlPaths.append(realmFilePath)
//        
//        
//        // 5. 압축
//        do {
//            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "Grind_DailyRecord")
//            print("zip 파일 저장 위치: \(zipFilePath)")
//            showActivityViewController()
//            
//        } catch {
//            print("압축을 실패했습니다.")
//        }
//        
//        // 6. ActivityViewController
//        // - 성공을 했을 경우에만 띄움
//        showActivityViewController()
//    }
//    
//    func showActivityViewController() {
//        // 도큐먼트 경로 가져와라.
//        guard let path = documentDirectoryPath() else {
//            print("Document 위치에 오류가 있습니다.")
//            return
//        }
//
//        // 백업 파일은 zip 키워드가 붙어있을 것이다.
//        // - URL 형태 : Realm File에 대한 것 (세부 경로)
//        let backUpFileURL = path.appendingPathComponent("Grind_DailyRecord.zip")
//        let viewController = UIActivityViewController(activityItems: [backUpFileURL], applicationActivities: [])
//        self.present(viewController, animated: true)
//    }
////
////
////    // 복구 버튼을 눌렀을 때에는 Document Picker를 가져와서 백업 파일을 확인할 수 있어야 함.
////    func restoreButtonClicked() {
////        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.archive], asCopy: true)
////        documentPicker.delegate = self
////        documentPicker.allowsMultipleSelection = false
////        self.present(documentPicker, animated: true)
////    }
////
////    // 오픈소스 라이선스 띄우기
////    func showOpenSourceLicense() {
////
////        let vc = AcknowListViewController(fileNamed: "Package.resolved")
////        let navigationController = UINavigationController(rootViewController: vc)
////        present(navigationController, animated: true, completion: nil)
////    }
//}
