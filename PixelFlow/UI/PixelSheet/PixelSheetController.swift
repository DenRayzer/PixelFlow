//
//  ViewController.swift
//  PixelFlow
//
//  Created by Елизавета on 03.04.2021.
//

import UIKit

class ViewController: UIViewController {
    var collevtionView: UICollectionView!
    var array = [1,2,3,4,5,6,7,8]

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.PF.background
        setupCollectionView()
        setupCollectionView()

    }

    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .camera, target: nil, action: nil)
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()

        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collevtionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(collevtionView)
        collevtionView.layout.vertical.equal(to: view.safeAreaLayoutGuide)
        collevtionView.layout.horizontal.equal(to: view)
//        collevtionView.translatesAutoresizingMaskIntoConstraints = false
        collevtionView.register(PixelSheetCell.self, forCellWithReuseIdentifier: "collectionViewCell")
        collevtionView.dataSource = self
        collevtionView.isPagingEnabled = true
        collevtionView.backgroundColor = UIColor.PF.background

    }

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        array.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! PixelSheetCell
        collectionView.transform = CGAffineTransform(scaleX:-1,y: 1)
        return cell
    }




}

