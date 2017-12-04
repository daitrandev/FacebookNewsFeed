//
//  ViewController.swift
//  Facebook
//
//  Created by Dai Tran on 12/1/17.
//  Copyright © 2017 Dai Tran. All rights reserved.
//

import UIKit

class NewsFeedCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

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
        return collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }
}

class FeedCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "zuckprofile"))
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let labelName: UILabel = {
        let labelName = UILabel()
        labelName.numberOfLines = 2
        let attributedText = NSMutableAttributedString(string: "Mark Zuckerberg", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "\nDecember 18 * San Francisco ", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12), NSAttributedStringKey.foregroundColor: UIColor(red: 155/255, green: 161/255, blue: 171/255, alpha: 1)]))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedText.string.count))
        
        let textAttachment = NSTextAttachment()
        textAttachment.image = UIImage(named: "globe_small")
        textAttachment.bounds = CGRect(x: 0, y: -2, width: 12, height: 12)
        attributedText.append(NSAttributedString(attachment: textAttachment))
        
        labelName.attributedText = attributedText
        return labelName
    }()
    
    let statusTextView: UITextView =  {
        let textView = UITextView()
        textView.text = "Meanwhile, Beast tuned to the dark side."
        textView.font = UIFont.systemFont(ofSize: 14)
        return textView
    }()
    
    let statusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "zuckdog")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = false
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = .white
        addSubview(imageView)
        addSubview(labelName)
        addSubview(statusTextView)
        addSubview(statusImageView)
        _ = imageView.constraint(top: topAnchor, bottom: nil, left: leftAnchor, right: nil, topConstant: 8, bottomConstant: 0, leftConstant: 8, rightConstant: 0)
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        _ = labelName.constraint(top: topAnchor, bottom: nil, left: imageView.rightAnchor, right: nil, topConstant: 16, bottomConstant: 0, leftConstant: 8, rightConstant: 0)
        
        _ = statusTextView.constraint(top: imageView.bottomAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, topConstant: 8, bottomConstant: 0, leftConstant: 8, rightConstant: 0)
        statusTextView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        _ = statusImageView.constraint(top: statusTextView.bottomAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, topConstant: 0, bottomConstant: 0, leftConstant: 0, rightConstant: 0)
    }
}

