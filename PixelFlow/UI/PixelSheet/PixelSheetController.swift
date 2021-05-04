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
    var array = [Year(year: 2021), Year(year: 2020), Year(year: 2019), Year(year: 2018), Year(year: 2017)]
    var currentYearIndex = 0
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
        setupHeaderButtons()
    }

    private func setupNavigationBar() {
        header = Header(frame: .zero)
        view.addSubview(header)
        header.layout.horizontal.equal(to: view)
        header.layout.height.equal(to: 60)
        header.layout.top.equal(to: view.safeAreaLayoutGuide, offset: 16)
    }

    private func setupCollectionView() {
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionViewFlowLayout.minimumInteritemSpacing = 0
        collectionViewFlowLayout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        view.addSubview(collectionView)
        collectionView.layout.top.equal(to: header.layout.bottom)
        collectionView.layout.bottom.equal(to: view)
        collectionView.layout.horizontal.equal(to: view)
        collectionView.register(PixelSheetCell.self, forCellWithReuseIdentifier: "collectionViewCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
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

    private func setupHeaderButtons() {
        let leftRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleHeaderLeftButtonTap(_:)))
        header.leftButton.addGestureRecognizer(leftRecognizer)
        let rightRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleHeaderRightButtonTap(_:)))
        header.rightButton.addGestureRecognizer(rightRecognizer)
    }

    @objc
    func handleHeaderLeftButtonTap(_ sender: UITapGestureRecognizer? = nil) {
        guard var currentIndexPath = collectionView.indexPathsForVisibleItems.first else { return }
        if currentYearIndex == array.count - 1 { return }
        currentIndexPath.row += 1
        currentYearIndex += 1
        header.titleButton.setTitle(String(array[currentYearIndex].year), for: .normal)
        collectionView.setContentOffset(CGPoint(x: CGFloat(currentYearIndex) * collectionView.frame.width, y: 0), animated: true)
        lastContentOffset = collectionView.contentOffset.x
    }

    @objc
    func handleHeaderRightButtonTap(_ sender: UITapGestureRecognizer? = nil) {
        guard var currentIndexPath = collectionView.indexPathsForVisibleItems.first else { return }
        if currentYearIndex == 0 { return }
        currentIndexPath.row -= 1
        currentYearIndex -= 1
        header.titleButton.setTitle(String(array[currentYearIndex].year), for: .normal)
        collectionView.setContentOffset(CGPoint(x: CGFloat(currentYearIndex) * collectionView.frame.width, y: 0), animated: true)
        lastContentOffset = collectionView.contentOffset.x
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        array.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! PixelSheetCell
        cell.year = array[indexPath.row]
        cell.transform = CGAffineTransform(scaleX: -1, y: 1)
        return cell
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        lastContentOffset = CGFloat(currentYearIndex) * collectionView.frame.width
        if lastContentOffset > scrollView.contentOffset.x && lastContentOffset <= scrollView.contentSize.width - scrollView.frame.width {
            if currentYearIndex == 0 { return }
            currentYearIndex -= 1
            header.titleButton.setTitle(String(array[currentYearIndex].year), for: .normal)
            lastContentOffset = scrollView.contentOffset.x
        } else if lastContentOffset < scrollView.contentOffset.x && scrollView.contentOffset.x > 0 {
            if currentYearIndex == array.count - 1 { return }
            currentYearIndex += 1
            header.titleButton.setTitle(String(array[currentYearIndex].year), for: .normal)
            lastContentOffset = scrollView.contentOffset.x
        }
    }
}
