//
//  ViewController.swift
//  PixelFlow
//
//  Created by Елизавета on 03.04.2021.
//

import UIKit

class ViewController: UIViewController {
    var collectionView: UICollectionView!
    var header: Header!
    var array = [1, 2, 3, 4, 5, 6, 7, 8]
    private var lastContentOffset: CGFloat = 0
    let collectionViewFlowLayout = UICollectionViewFlowLayout()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    private func setupViews() {
        view.backgroundColor = UIColor.PF.background

        setupNavigationBar()
        setupCollectionView()
        setupSettingsButton()
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
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionViewFlowLayout.minimumInteritemSpacing = 0
        collectionViewFlowLayout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        view.addSubview(collectionView)
        collectionView.layout.top.equal(to: header.layout.bottom, offset: 12)
        collectionView.layout.bottom.equal(to: view)
        collectionView.layout.horizontal.equal(to: view)
        collectionView.register(PixelSheetCell.self, forCellWithReuseIdentifier: "collectionViewCell")
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = UIColor.PF.background
    }

    override func viewDidLayoutSubviews() {
        collectionViewFlowLayout.itemSize = collectionView.frame.size
    }

    private func setupSettingsButton() {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "home"))
        let settingsButton = Button(type: .floating, view: imageView)
        view.addSubview(settingsButton)
        settingsButton.layout.height.equal(to: 55)
        settingsButton.layout.width.equal(to: 55)
        settingsButton.layout.bottom.equal(to: view, offset: -18)
        settingsButton.layout.right.equal(to: view, offset: -18)
        collectionView.transform = CGAffineTransform(scaleX: -1, y: 1)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        array.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! PixelSheetCell
        cell.pixelLayout.configureCell(with: Year(year: 2021))
        cell.transform = CGAffineTransform(scaleX: -1, y: 1)
        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if lastContentOffset > scrollView.contentOffset.x && lastContentOffset < scrollView.contentSize.width - scrollView.frame.width {
            print("move up")
        } else if lastContentOffset < scrollView.contentOffset.x && scrollView.contentOffset.x > 0 {
            print("move down")
        }

        lastContentOffset = scrollView.contentOffset.x
    }
}
