//
//  ViewController.swift
//  PixelFlow
//
//  Created by Елизавета on 03.04.2021.
//

import UIKit

class ViewController: UIViewController {
    var collevtionView: UICollectionView!
    var header: Header!
    var array = [1,2,3,4,5,6,7,8]

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.PF.background
        setupNavigationBar()
        setupCollectionView()
    }

    private func setupNavigationBar() {
        header = Header(frame: .zero)
        view.addSubview(header)
        header.layout.horizontal.equal(to: view)
        header.layout.height.equal(to: 44)
        header.layout.top.equal(to: view.safeAreaLayoutGuide, offset: 16)

      //  navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .camera, target: nil, action: nil)
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()

        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height - 89)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collevtionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(collevtionView)
        collevtionView.layout.top.equal(to: header.layout.bottom, offset: 12)
        collevtionView.layout.bottom.equal(to: view)
        collevtionView.layout.horizontal.equal(to: view)
//        collevtionView.translatesAutoresizingMaskIntoConstraints = false
        collevtionView.register(PixelSheetCell.self, forCellWithReuseIdentifier: "collectionViewCell")
        collevtionView.dataSource = self
        collevtionView.isPagingEnabled = true
        collevtionView.backgroundColor = UIColor.PF.background

        let imageView = UIImageView(image: #imageLiteral(resourceName: "home"))
        let playView = Button(type: .floating, view: imageView)
        view.addSubview(playView)
        playView.layout.height.equal(to: 55)
        playView.layout.width.equal(to: 55)
        playView.layout.bottom.equal(to: view.safeAreaLayoutGuide, offset: -8)
        playView.layout.right.equal(to: view.safeAreaLayoutGuide, offset: -18)
        

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

