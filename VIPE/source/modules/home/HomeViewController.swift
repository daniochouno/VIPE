//
// Created by Daniel  Martinez Muñoz on 16/3/16.
// Copyright (c) 2016 Daniel Martínez. All rights reserved.
//

import UIKit
import AlamofireImage

class HomeViewController : UIViewController {

    let presenter = HomePresenter()

    @IBOutlet weak var collectionView: UICollectionView!

    @IBAction func logoutButtonPressed(sender: UIBarButtonItem) {
        self.presenter.logoutAction()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPresenter()
        setUpCollectionView()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setUpNavigationBar()
    }

    override func viewDidAppear( animated: Bool ) {
        super.viewDidAppear(animated)
        loadData()
    }

    func setUpPresenter() {
        self.presenter.output = self
    }

    func setUpNavigationBar() {
        self.navigationController?.navigationBar.backgroundColor = UIColor.lightGrayColor()
        self.navigationController?.navigationBarHidden = false
    }

    func setUpCollectionView() {
        self.collectionView.dataSource = self
    }

    func loadData() {
        self.presenter.loadDataAction()
    }

}

extension HomeViewController : UICollectionViewDataSource {

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter.numberOfItemsInSection(section)
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("HomeViewModelCell", forIndexPath: indexPath) as! HomeViewModelCell

        cell.nameLabel.text = ""
        cell.thumbnailImageView.image = UIImage()

        if let randomUser = self.presenter.cellForItemAtIndexPath(indexPath) {

            cell.nameLabel.text = randomUser.fullName()
            if let pictureThumbnail = randomUser.pictureThumbnail {
                cell.thumbnailImageView.af_setImageWithURL(NSURL(string: pictureThumbnail)!)
            }

        }

        return cell

    }

}

extension HomeViewController : HomePresenterOutput {

    func didLoadData() {
        self.collectionView.reloadData()
    }

    func didFailLoadData( message: String ) {
        print("didFailLoadData: \(message)")
    }

    func didLogout() {
        self.navigationController?.popViewControllerAnimated(true)
    }

}
