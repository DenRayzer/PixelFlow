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
    var array = [Year(year: 2021), Year(year: 2020), Year(year: 2019), Year(year: 2018), Year(year: 2017)]
    var currentYearIndex = 0
    private var lastContentOffset: CGFloat = 0
    let collectionViewFlowLayout = UICollectionViewFlowLayout()
    var floaty = Floaty()

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
  //      header.layout.height.equal(to: 60)
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
        layoutFAB()
        floaty.addDragging()
        
//        let floatingActionButton = LiquidFloatingActionButton(frame: floatingFrame)
//        floatingActionButton.dataSource = self
//        floatingActionButton.delegate = self
        
//        let imageView = UIImageView(image: #imageLiteral(resourceName: "home"))
//        let settingsButton = Button(type: .floating, view: imageView)
//        view.addSubview(settingsButton)
//        settingsButton.layout.height.equal(to: 55)
//        settingsButton.layout.width.equal(to: 55)
//        settingsButton.layout.bottom.equal(to: view, offset: -18)
//        settingsButton.layout.right.equal(to: view, offset: -18)
//        collectionView.transform = CGAffineTransform(scaleX: -1, y: 1)
    }
    
    func layoutFAB() {
        floaty.frame = CGRect(x: view.frame.width - 20 - view.safeAreaInsets.bottom, y: view.frame.height - 20 - view.safeAreaInsets.bottom, width: 55, height: 55)
        floaty.buttonImage = #imageLiteral(resourceName: "home")
      let item = FloatyItem()
      item.hasShadow = false
      item.buttonColor = UIColor.blue
      item.circleShadowColor = UIColor.red
      item.titleShadowColor = UIColor.blue
      item.titleLabelPosition = .right
      item.title = "titlePosition right"
      item.handler = { item in
        
      }
      
      floaty.hasShadow = false
      floaty.addItem(title: "I got a title")
      floaty.addItem("I got a icon", icon: UIImage(named: "icShare"))
      floaty.addItem("I got a handler", icon: UIImage(named: "icMap")) { item in
        let alert = UIAlertController(title: "Hey", message: "I'm hungry...", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Me too", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
      }
      floaty.addItem(item: item)
   //   floaty.paddingX = self.view.frame.width/2 - floaty.frame.width/2
      floaty.fabDelegate = self
      
        floaty.overlayColor = .clear
      self.view.addSubview(floaty)
      
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

extension PixelSheetController: UICollectionViewDataSource, UICollectionViewDelegate {
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

extension PixelSheetController: FloatyDelegate {
    
}

//extension UIView {
//    func addDragging(){
//
//        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(draggedAction(_ :)))
//        self.addGestureRecognizer(panGesture)
//    }
//
//    @objc private func draggedAction(_ pan:UIPanGestureRecognizer){
//
//        let translation = pan.translation(in: self.superview)
//        self.center = CGPoint(x: self.center.x + translation.x, y: self.center.y + translation.y)
//        pan.setTranslation(CGPoint.zero, in: self.superview)
//    }
//}
