//
//  SettingViewController.swift
//  Grind
//
//  Created by 최형민 on 2022/09/14.
//

import UIKit
import ProgressHUD
import Zip
import MessageUI
import AcknowList

struct Setting: Hashable {
    let id = UUID().uuidString
    let title: String
    let image: String
}

final class SettingViewController: BaseViewController {
    
    private let settingView = SettingView()
    
    private let setting = [
        Setting(title: "데이터 백업", image: "externaldrive"),
        Setting(title: "데이터 복구", image: "arrow.counterclockwise.icloud"),
        Setting(title: "버전 정보", image: "doc"),
        Setting(title: "건강 앱 접근권한 변경", image: "person.badge.shield.checkmark"),
        Setting(title: "오픈소스 라이선스", image: "line.3.crossed.swirl.circle.fill"),
        Setting(title: "개발자에게 문의하기", image: "envelope.badge")
    ]
    
    private let repository = DailyRecordRepository.repository
    
//    private let settingView = SettingView()
    
    // cell 등록
//    private var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, String>!
    
    // Int: section 번호, String: 각 row 당 데이터
    private var dataSource: UICollectionViewDiffableDataSource<Int, Setting>!
    
    override func configureUI() {
        super.configureUI()
        
        settingView.collectionView.collectionViewLayout = createLayout()
        configureDataSource()
        settingView.collectionView.delegate = self
        
        self.view = settingView
        
//        settingView.tableView.delegate = self
//        settingView.tableView.dataSource = self
//        settingView.tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.navigationItem.title = "설정"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: Constants.Font.subTitleFont as Any]
        self.navigationItem.titleView?.tintColor = Constants.Color.primaryText
    }
}

extension SettingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // 새로 추가된 row를 클릭했을 때 오류 생김 (indexPath 기준으로 실행이 돼서)
        // let item = list[indexPath.item]
        // dataSource에서 업데이트된 리스트에서 itemIdentifier를 통해 item을 불러온다
        
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        
//        let alert = UIAlertController(title: item, message: "클릭!", preferredStyle: .alert)
//        let ok = UIAlertAction(title: "확인", style: .cancel)
//        alert.addAction(ok)
//        present(alert, animated: true)
    }
}

extension SettingViewController {
    
    private func createLayout() -> UICollectionViewLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
    
    private func configureDataSource() {
        // 여기서 선언해줄거면 타입 추론을 할 수 있게 명시를 해줘야함 (string)
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Setting>(handler: { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            
            content.text = itemIdentifier.title
            content.image = UIImage(systemName: "\(itemIdentifier.image)")
            content.secondaryText = indexPath.item == 2 ? "1.1.0" : nil
            cell.contentConfiguration = content
            
            var background = UIBackgroundConfiguration.listPlainCell()
            background.strokeWidth = 2
            background.strokeColor = .brown
            cell.backgroundConfiguration = background
        })
        
        // collectionView.dataSource = self -> 더 이상 안 써도 됨
        // numberOfItemsInSection, cellForItemAt Method 대신에 여기 안에서 모두 처리함
        dataSource = UICollectionViewDiffableDataSource(collectionView: settingView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            // cellForItemAt 역할
            // 이 해당 코드가 실행되면 (셀 재사용), 위에 있는 cellRegistration의 클로져가 실행이 돼서 셀이 그려짐)
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        // Initial
        var snapshot = NSDiffableDataSourceSnapshot<Int, Setting>()
        snapshot.appendSections([0])
        snapshot.appendItems(setting)
        // reloadData 코드의 역할을 한다고 생각하면 됨
        dataSource.apply(snapshot)
    }
    
    private func documentDirectoryPath() -> URL? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil } // Document 경로
        return documentDirectory
    }
    
    private func backupButtonClicked() {
        
        var urlPaths = [URL]()
        
        // 1. Document 위치 확인을 먼저 한다.
        // 저장을 해야해서 위치를 알아보는 과정
        guard let path = documentDirectoryPath() else {
            print("Document 위치에 오류가 있습니다.")
            return
        }
        
        // 2. Realm 파일의 경로를 확인한다. document 위치 뒤에 default.realm 붙여서 확인하면 됨
        // URL 타입
        let realmFilePath = path.appendingPathComponent("default.realm")
        
        // 3. 백업 파일 확인 과정 (Realm 파일 없으면 백업 불가)
        // 사용자가 어떠한 파일도 저장하지 않은 경우
        guard FileManager.default.fileExists(atPath: realmFilePath.path) else {
            print("백업할 파일이 없습니다.")
            return
        }
        
        // 4. url 기반으로 압축
        urlPaths.append(realmFilePath)
        
        
        // 5. 압축
        do {
            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "Grind_DailyRecord")
            print("zip 파일 저장 위치: \(zipFilePath)")
            showActivityViewController()
            
        } catch {
            print("압축을 실패했습니다.")
        }
        
        // 6. ActivityViewController
        // - 성공을 했을 경우에만 띄움
        showActivityViewController()
    }
    
    private func showActivityViewController() {
        // 도큐먼트 경로 가져와라.
        guard let path = documentDirectoryPath() else {
            print("Document 위치에 오류가 있습니다.")
            return
        }
        
        // 백업 파일은 zip 키워드가 붙어있을 것이다.
        // - URL 형태 : Realm File에 대한 것 (세부 경로)
        let backUpFileURL = path.appendingPathComponent("Grind_DailyRecord.zip")
        let viewController = UIActivityViewController(activityItems: [backUpFileURL], applicationActivities: [])
        self.present(viewController, animated: true)
    }
    
    
    // 복구 버튼을 눌렀을 때에는 Document Picker를 가져와서 백업 파일을 확인할 수 있어야 함.
    private func restoreButtonClicked() {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.archive], asCopy: true)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        self.present(documentPicker, animated: true)
    }
    
    // 오픈소스 라이선스 띄우기
    private func showOpenSourceLicense() {
        
        let vc = AcknowListViewController(fileNamed: "Package.resolved")
        let navigationController = UINavigationController(rootViewController: vc)
        present(navigationController, animated: true, completion: nil)
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SettingTableViewCell else { return UITableViewCell() }
        
        let row = indexPath.row
        
        switch row {
        case 0:
            cell.titleImage.image = UIImage(systemName: "externaldrive")
            cell.titleLabel.text = "데이터 백업"
        case 1:
            cell.titleImage.image = UIImage(systemName: "arrow.counterclockwise.icloud")
            cell.titleLabel.text = "데이터 복구"
//        case 2:
//            cell.titleImage.image = UIImage(systemName: "arrow.counterclockwise")
//            cell.titleLabel.text = "데이터 초기화"
        case 2:
            cell.titleImage.image = UIImage(systemName: "doc")
            cell.titleLabel.text = "버전 정보"
            cell.versionLabel.text = "1.0"
        case 3:
            cell.titleImage.image = UIImage(systemName: "person.badge.shield.checkmark")
            cell.titleLabel.text = "건강 앱 접근권한 변경"
        case 4:
            cell.titleImage.image = UIImage(systemName: "line.3.crossed.swirl.circle.fill")
            cell.titleLabel.text = "오픈소스 라이선스"
        case 5:
            cell.titleImage.image = UIImage(systemName: "envelope.badge")
            cell.titleLabel.text = "개발자에게 문의하기"
        default:
            break
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        
        switch row {
        case 0:
            backupButtonClicked()
        case 1:
            restoreButtonClicked()
//        case 2:
//            self.repository.resetRealm()
//            self.repository.addRecord(item: <#T##DailyRecord#>)
        case 3:
            HealthKitManager.shared.checkAuthorization()
        case 4:
            showOpenSourceLicense()
        case 5:
            mailButtonClicked()
        default:
            break
        }
    }
    
    
}

extension SettingViewController: UIDocumentPickerDelegate {
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("취소!!")
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFileURL = urls.first else {
            print("파일을 찾을 수 없어요.")
            return
        }
        
        guard let path = documentDirectoryPath() else {
            print("도큐먼트 위치를 찾을 수 없어요.")
            return
        }
        
        // 샌드박스로 파일을 가져와야하는데
        let sandboxFileURL = path.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        // 파일 이미 존재하면 그냥 겹쳐 쓰는거지
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            
            let fileURL = path.appendingPathComponent("Shopping_List.zip")
            
            do {
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    ProgressHUD.showProgress(progress)
                }, fileOutputHandler: { unzippedFile in
                    print("복구완료! : ", unzippedFile)
                    ProgressHUD.dismiss()
                })
                
            } catch {
                print("압축 해제 실패! 복구 실패!!!")
            }
        } else {
            
            do {
                // 없으면 파일을 옮겨와야함
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                
                let fileURL = path.appendingPathComponent("Shopping_List.zip")
                
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print(progress)
                }, fileOutputHandler: { unzippedFile in
                    print("복구완료! : ", unzippedFile)
                })
                
            } catch {
                print("압축 해제 실패! 복구 실패!!!")
            }
            
        }
    }
    
}

extension SettingViewController: MFMailComposeViewControllerDelegate {
    private func mailButtonClicked() {
        
        guard MFMailComposeViewController.canSendMail() else {
            showMailErrorAlert()
            return
        }
        
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        composeVC.setToRecipients(["kelvinchoi@naver.com"])
        composeVC.setSubject("Grind앱 관련 문의 및 의견")
        composeVC.setMessageBody("\n < 이곳에 문의 또는 의견을 적어주세요 >", isHTML: false)
        
        self.present(composeVC, animated: true, completion: nil)
    }
    
    private func showMailErrorAlert() {
      let controller = UIAlertController(title: "", message: "메일 설정을 확인해주세요", preferredStyle: .alert)
      controller.addAction(UIAlertAction(title: "확인", style: .default))
      present(controller, animated: true)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
