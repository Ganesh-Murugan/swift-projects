//
//  ViewController.swift
//  AppScreen
//
//  Created by zoho on 21/06/22.
//

import UIKit

class AppScreenViewController: UIViewController {
    private var apps = Apps().apps
    
    private var appScreenCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
   
    private var layout: UICollectionViewFlowLayout = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 35
        layout.minimumInteritemSpacing = 25
        layout.sectionInset = UIEdgeInsets(top: 1, left: 20, bottom: 1, right: 20)
        layout.itemSize = CGSize(width: 70, height: 70)
        
        return layout
    }()
    
    private func setupAppScreenView(){
        appScreenCollectionView.delegate = self
        appScreenCollectionView.dataSource = self
        appScreenCollectionView.collectionViewLayout = layout
        appScreenCollectionView.backgroundColor = .white
        appScreenCollectionView.showsHorizontalScrollIndicator = false
        appScreenCollectionView.isPagingEnabled = true
        appScreenCollectionView.register(AppIconCollectionViewCell.self, forCellWithReuseIdentifier: Identifiers.appIconCollectionViewCell)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        appScreenCollectionView.frame = CGRect(x: 0, y: view.safeAreaInsets.top + 120, width: view.frame.size.width, height: view.frame.size.height - 420)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppScreenView()
        print(apps.count)
        view.addSubview(appScreenCollectionView)
    }
}

extension AppScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private var appsCount: Int { apps.count }
    private var noOfSections: Int { self.numberOfSections(in: appScreenCollectionView) }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(section, noOfSections)
        return 20
//        if appsCount % 20 == 0, appsCount > 20{
//            return appsCount/2
//        }
//
//        return appsCount > 20 ? (section == noOfSections - 1 ? appsCount%20 : 20) : appsCount
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
//        return appsCount > 20 ? (appsCount % 20 > 0 ? appsCount/20 + 1 : appsCount/20) : 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.appIconCollectionViewCell, for: indexPath) as! AppIconCollectionViewCell
        print(apps[indexPath.item])
        cell.add(apps[indexPath.item].appName)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        true
    }
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        apps.swapAt(sourceIndexPath.item, destinationIndexPath.item)
    }

}

