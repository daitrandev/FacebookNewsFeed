//
//  ViewController.swift
//  Facebook
//
//  Created by Dai Tran on 12/1/17.
//  Copyright © 2017 Dai Tran. All rights reserved.
//

import UIKit

class NewsFeedCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var statusImageView: UIImageView?
    var zoomImageView = UIImageView()
    
    lazy var blackView: UIView = {
        let blackView = UIView(frame: view.frame)
        blackView.backgroundColor = .black
        return blackView
    }()
    
    lazy var navCoverView: UIView = {
        let navCoverView = UIView()
        navCoverView.backgroundColor = .black
        navCoverView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 66)
        navCoverView.alpha = 0
        return navCoverView
    }()
    
    lazy var tabBarCoverView: UIView = {
        let tabBarCoverView = UIView()
        tabBarCoverView.backgroundColor = .black
        tabBarCoverView.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: 50)
        tabBarCoverView.alpha = 0
        return tabBarCoverView
    }()
    
    var posts: [Post] = [Post(name: "Mark Zuckerberg", profileImageName: "zuckprofile", statusText: "By giving people the power to share, we're making the world more transparent.", statusImageName: "zuckdog", numLikes: 400, numComments: 123, statusImageURL: "http://e02-elmundo.uecdn.es/assets/multimedia/imagenes/2016/06/08/14653888785503.jpg"),
                         Post(name: "Steve Jobs", profileImageName: "steve_profile", statusText: "Design is not just what it looks like and feels like. Design is how it works.\n\n" + "Being the richest man in the cemetery doesn't matter to me. Going to bed at night saying we've done something wonderful, that's what matters to me.\n\n" + "Sometimes when you innovate, you make mistakes. It is best to admit them quickly, and get on with improving your other innovations.", statusImageName: "steve_status", numLikes: 1000, numComments: 55, statusImageURL: "http://cafefcdn.com/thumb_w/650/2016/steve-jobs-31-1476758906971.jpg"),
                         Post(name: "Mahatma Gandhi", profileImageName: "gandhi_profile", statusText: "Live as if you were to die tomorrow; learn as if you were to live forever.\n" + "The weak can never forgive. Forgiveness is the attribute of the strong.\n" + "Happiness is when what you think, what you say, and what you do are in harmony.", statusImageName: "gandhi_status", numLikes: 31, numComments: 1, statusImageURL: "http://s3.india.com/wp-content/uploads/2017/01/gandhi-2.jpg")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.title = "News Feed"
        collectionView?.backgroundColor = UIColor(white: 0.9, alpha: 1)
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: "cell")
        collectionView?.alwaysBounceVertical = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FeedCell
        cell.post = posts[indexPath.item]
        cell.feedCellAnimationDelegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let textView = UITextView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 0))
        textView.text = posts[indexPath.item].statusText
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.sizeToFit()
        return CGSize(width: view.frame.width, height: textView.contentSize.height + 380)
    }
}

extension NewsFeedCollectionViewController: FeedCellAnimationDelegate {
    
    func animate(statusImageView: UIImageView) {
        if let startingFrame = statusImageView.superview?.convert(statusImageView.frame, to: nil) {
            self.statusImageView = statusImageView
            blackView.backgroundColor = .black
            view.addSubview(blackView)
            
            zoomImageView.isUserInteractionEnabled = true
            zoomImageView.contentMode = .scaleAspectFill
            zoomImageView.image = statusImageView.image
            zoomImageView.backgroundColor = .red
            zoomImageView.frame = startingFrame
            zoomImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(zoomOut)))
            view.addSubview(zoomImageView)
            
            statusImageView.alpha = 0
            
            if let keyWindow = UIApplication.shared.keyWindow {
                keyWindow.addSubview(navCoverView)
                keyWindow.addSubview(tabBarCoverView)
            }
      
            UIView.animate(withDuration: 0.5, animations: {
                let y = self.view.frame.height / 2 - statusImageView.frame.height / 2
                self.zoomImageView.frame = CGRect(x: 0, y: y, width: startingFrame.width, height: startingFrame.height)
                self.blackView.alpha = 1
                self.navCoverView.alpha = 1
                self.tabBarCoverView.alpha = 1
            })
        }
    }
    
    @objc private func zoomOut() {
        guard let statusImageView = self.statusImageView else { return }
        if let startingFrame = statusImageView.superview?.convert(statusImageView.frame, to: nil) {
            UIView.animate(withDuration: 0.5, animations: {
                self.zoomImageView.frame = startingFrame
                self.blackView.alpha = 0
                self.navCoverView.alpha = 0
                self.tabBarCoverView.alpha = 0
            }, completion: { (completed) in
                self.blackView.removeFromSuperview()
                self.zoomImageView.removeFromSuperview()
                self.navCoverView.removeFromSuperview()
                self.tabBarCoverView.removeFromSuperview()
                statusImageView.alpha = 1
            })
        }
    }
}



