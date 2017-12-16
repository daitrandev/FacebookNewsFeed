//
//  FeedCell.swift
//  Facebook
//
//  Created by Dai Tran on 12/6/17.
//  Copyright © 2017 Dai Tran. All rights reserved.
//

import UIKit

protocol FeedCellAnimationDelegate: class {
    func animate(statusImageView: UIImageView)
}

class FeedCell: UICollectionViewCell {
    
    weak var feedCellAnimationDelegate: FeedCellAnimationDelegate?
    
    var post: Post? {
        didSet {
            guard let post = post else {return}
            profileImageView.image = UIImage(named: post.profileImageName)
            statusTextView.text = post.statusText
            statusImageView.image = UIImage(named: post.statusImageName)
            likesCommentsLabel.text = "\(post.numLikes) Likes     \(post.numComments)k Comments"
            
            let attributedText = NSMutableAttributedString(string: "\(post.name)", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
            attributedText.append(NSAttributedString(string: "\nDecember 18 * San Francisco ", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12), NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 155, green: 161, blue: 171)]))
            
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4
            attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedText.string.count))
            
            let textAttachment = NSTextAttachment()
            textAttachment.image = UIImage(named: "globe_small")
            textAttachment.bounds = CGRect(x: 0, y: -2, width: 12, height: 12)
            attributedText.append(NSAttributedString(attachment: textAttachment))
            
            labelName.attributedText = attributedText

        }
    }
    
    let profileImageView: UIImageView = {
        let profileImageView = UIImageView(image: UIImage(named: "zuckprofile"))
        profileImageView.contentMode = .scaleToFill
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        return profileImageView
    }()
    
    let labelName: UILabel = {
        let labelName = UILabel()
        labelName.numberOfLines = 2
        
        return labelName
    }()
    
    let statusTextView: UITextView =  {
        let textView = UITextView()
        textView.text = "Meanwhile, Beast tuned to the dark side."
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.isEditable = false
        return textView
    }()
    
    let statusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "zuckdog")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = false
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let likesCommentsLabel: UILabel = {
        let label = UILabel()
        label.text = "488 Likes     10.7k Comments"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.rgb(red: 155, green: 161, blue: 171)
        return label
    }()
    
    let likeButton: UIButton = FeedCell.createBottomButton(title: "Like", imageName: "like")
    let commentButton: UIButton = FeedCell.createBottomButton(title: "Comment", imageName: "comment")
    let shareButton: UIButton = FeedCell.createBottomButton(title: "Share", imageName: "share")
    
    let seperatedLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    static func createBottomButton(title: String, imageName: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.rgb(red: 143, green: 150, blue: 163), for: .normal)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        return button
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func animateStatusImage() {
        feedCellAnimationDelegate?.animate(statusImageView: statusImageView)
    }
    
    func setupView() {
        backgroundColor = .white
        addSubview(profileImageView)
        addSubview(labelName)
        addSubview(statusTextView)
        addSubview(statusImageView)
        addSubview(likesCommentsLabel)
        addSubview(likeButton)
        addSubview(commentButton)
        addSubview(shareButton)
        addSubview(seperatedLine)
        
        statusImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateStatusImage)))
        
        _ = profileImageView.constraint(top: topAnchor, bottom: nil, left: leftAnchor, right: nil, topConstant: 8, bottomConstant: 0, leftConstant: 8, rightConstant: 0)
        profileImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        _ = labelName.constraint(top: topAnchor, bottom: nil, left: profileImageView.rightAnchor, right: nil, topConstant: 16, bottomConstant: 0, leftConstant: 8, rightConstant: 0)
        
        _ = statusTextView.constraint(top: profileImageView.bottomAnchor, bottom: statusImageView.topAnchor, left: leftAnchor, right: rightAnchor, topConstant: 0, bottomConstant: 0, leftConstant: 8, rightConstant: -8)
        
        _ = statusImageView.constraint(top: nil, bottom: likesCommentsLabel.topAnchor, left: leftAnchor, right: rightAnchor, topConstant: 0, bottomConstant: 0, leftConstant: 0, rightConstant: 0)
        statusImageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        _ = likesCommentsLabel.constraint(top: nil, bottom: seperatedLine.topAnchor, left: leftAnchor, right: rightAnchor, topConstant: 0, bottomConstant: 0, leftConstant: 8, rightConstant: 8)
        likesCommentsLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true

        _ = seperatedLine.constraint(top: nil, bottom: likeButton.topAnchor, left: leftAnchor, right: rightAnchor, topConstant: 0, bottomConstant: 0, leftConstant: 8, rightConstant: 8)
        seperatedLine.heightAnchor.constraint(equalToConstant: 0.5).isActive = true

        _ = likeButton.constraint(top: nil, bottom: bottomAnchor, left: leftAnchor, right: commentButton.leftAnchor, topConstant: 0, bottomConstant: 0, leftConstant: 0, rightConstant: 0)
        likeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        likeButton.widthAnchor.constraint(equalTo: commentButton.widthAnchor).isActive = true

        _ = commentButton.constraint(top: nil, bottom: bottomAnchor, left: likeButton.rightAnchor, right: shareButton.leftAnchor, topConstant: 0, bottomConstant: 0, leftConstant: 0, rightConstant: 0)
        commentButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        commentButton.widthAnchor.constraint(equalTo: shareButton.widthAnchor).isActive = true

        _ = shareButton.constraint(top: nil, bottom: bottomAnchor, left: commentButton.rightAnchor, right: rightAnchor, topConstant: 0, bottomConstant: 0, leftConstant: 0, rightConstant: 0)
        shareButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        shareButton.widthAnchor.constraint(equalTo: likeButton.widthAnchor).isActive = true
    }
}
