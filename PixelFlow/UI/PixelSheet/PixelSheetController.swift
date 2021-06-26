//
//  ViewController.swift
//  PixelFlow
//
//  Created by Елизавета on 03.04.2021.
//

import UIKit
//import Floaty

class PixelSheetController: UIViewController {
    var collectionView: UICollectionView!
    var header: Header!
    var currentYearIndex = 0
    private var lastContentOffset: CGFloat = 0
    let collectionViewFlowLayout = UICollectionViewFlowLayout()
    var floaty = Floaty()
    var presenter: PixelSheetPresenterDelegate!



    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = PixelSheetPresenter()
        setupViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                print("We have permission")
            } else {
                print("Permission denied")
            }
        }
    }

    private func setupViews() {
        view.backgroundColor = UIColor.PF.background

        setupNavigationBar()
        setupCollectionView()
        setupSettingsButton()
        setupHeaderButtons()
    }

    private func setupNavigationBar() {
        header = Header(type: .calendar)
        view.addSubview(header)
        header.layout.horizontal.equal(to: view)
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
        collectionView.transform = CGAffineTransform(scaleX: -1, y: 1)
    }

    override func viewDidLayoutSubviews() {
        collectionViewFlowLayout.itemSize = collectionView.frame.size
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }

    private func setupSettingsButton() {
        layoutFAB()
        floaty.addDragging()
    }

    func layoutFAB() {
        floaty.buttonImage = UIImage(named: presenter.board.imageName)

        floaty.hasShadow = false

        floaty.addItem("pf_all_boards".localize(), icon: #imageLiteral(resourceName: "lib")) { item in
            let vc = MainMenuController()
            vc.modalPresentationStyle = .fullScreen

            self.present(vc, animated: true, completion: nil)
        }
        floaty.paddingX = view.safeAreaInsets.right + 20
        floaty.paddingY = view.safeAreaInsets.bottom + 20
        floaty.fabDelegate = self

        floaty.overlayColor = .clear
        self.view.addSubview(floaty)

    }

    private func setupHeaderButtons() {
        let leftRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleHeaderLeftButtonTap(_:)))
        header.rightButton.isEnabled = false
        header.leftButton.addGestureRecognizer(leftRecognizer)
        let rightRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleHeaderRightButtonTap(_:)))
        header.rightButton.addGestureRecognizer(rightRecognizer)
    }

    @objc
    func handleHeaderLeftButtonTap(_ sender: UITapGestureRecognizer? = nil) {
        header.rightButton.isEnabled = true
        guard var currentIndexPath = collectionView.indexPathsForVisibleItems.first else { return }
        if currentYearIndex == presenter.years.count - 1 { return }
        currentIndexPath.row += 1
        currentYearIndex += 1
        header.titleButton.setTitle(String(presenter.years[currentYearIndex].year), for: .normal)
        collectionView.setContentOffset(CGPoint(x: CGFloat(currentYearIndex) * collectionView.frame.width, y: 0), animated: true)
        lastContentOffset = collectionView.contentOffset.x
    }

    @objc
    func handleHeaderRightButtonTap(_ sender: UITapGestureRecognizer? = nil) {
        guard var currentIndexPath = collectionView.indexPathsForVisibleItems.first else { return }
        if currentYearIndex == 0 { return }
        currentIndexPath.row -= 1
        currentYearIndex -= 1
        if currentYearIndex == 0 {
            header.rightButton.isEnabled = false
        }
        header.titleButton.setTitle(String(presenter.years[currentYearIndex].year), for: .normal)
        collectionView.setContentOffset(CGPoint(x: CGFloat(currentYearIndex) * collectionView.frame.width, y: 0), animated: true)
        lastContentOffset = collectionView.contentOffset.x
    }
}

extension PixelSheetController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.years.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! PixelSheetCell
        cell.year = presenter.years[indexPath.row]
        cell.transform = CGAffineTransform(scaleX: -1, y: 1)
        return cell
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        lastContentOffset = CGFloat(currentYearIndex) * collectionView.frame.width
        if lastContentOffset > scrollView.contentOffset.x && lastContentOffset <= scrollView.contentSize.width - scrollView.frame.width {
            if currentYearIndex == 0 { return }
            currentYearIndex -= 1
            if currentYearIndex == 0 {
                header.rightButton.isEnabled = false
            }
            header.titleButton.setTitle(String(presenter.years[currentYearIndex].year), for: .normal)
            lastContentOffset = scrollView.contentOffset.x
        } else if lastContentOffset < scrollView.contentOffset.x && scrollView.contentOffset.x > 0 {
            header.rightButton.isEnabled = true
            if currentYearIndex == presenter.years.count - 1 { return }
            currentYearIndex += 1
            header.titleButton.setTitle(String(presenter.years[currentYearIndex].year), for: .normal)
            lastContentOffset = scrollView.contentOffset.x
        }
    }
}

extension PixelSheetController: FloatyDelegate {

}
