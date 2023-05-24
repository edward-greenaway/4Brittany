//
//  NewUserController.swift
//  WizardFlow
//
//  Created by Edward Greenaway on 11/3/2023.
//

import UIKit

class NewUserController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollAvatars: UIScrollView! {
        didSet{
            scrollAvatars.delegate = self
        }
    }
    
    @IBOutlet weak var pageControlAvatars: UIPageControl!
    
    @IBAction func textUserName(_ sender: Any) {
    }
    
    @IBOutlet weak var textUserNameField: UITextField!
    
    @IBAction func buttonSelectThatsMe(_ sender: Any) {
        print("Selected ... \(pageControlAvatars.currentPage)")
        if textUserNameField.text == "" {
            print("However no name entered!")
        }
        else {
            print("Is ... \(textUserNameField.text ?? "null, an error !")")
        }
    }
    
    var slides: [avatarSlide] = []
    // define the Avatar, their Name, and Filename for a "slide"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slides = createSlides()
        setupSlideScrollView(slides: slides)
        
        pageControlAvatars.numberOfPages = slides.count
        pageControlAvatars.currentPage = 0
        view.bringSubviewToFront(pageControlAvatars)
        
        // scrollAvatars.delegate = self
        
        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "New User View"
        
        textUserNameField.becomeFirstResponder()
        
        
        //        textUserNameField.setNeedsFocusUpdate() // how to pop the keyboard ???
        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
         /*
          * currently does not have any effect on totate refresh
          */
        setupSlideScrollView(slides: slides)
    }
    
    func createSlides() -> [avatarSlide] {
        
        // mock the database
        struct avatar {
            var title: String
            var filename: String
        }
        var avatars: [avatar] = [
            avatar(title: "Abrahan", filename: "icon_avatar_abraham"),
            avatar(title: "Esau", filename: "icon_avatar_esau"),
            avatar(title: "Esther", filename: "icon_avatar_esther"),
            avatar(title: "Haman", filename: "icon_avatar_haman"),
            avatar(title: "Issac", filename: "icon_avatar_isaac"),
        ]
        
        // for each Avatar create it's image view
        var avatarSlides = [avatarSlide]()
        
        avatars.forEach{ (ava) in avatarSlides.append(Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! avatarSlide)
            avatarSlides.last?.imageView.image = UIImage(named: ava.filename)
            avatarSlides.last?.imageTitle.text = ava.title
        }
        
        return avatarSlides
    }
    
    func setupSlideScrollView(slides : [avatarSlide]) {
        scrollAvatars.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollAvatars.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollAvatars.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollAvatars.addSubview(slides[i])
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControlAvatars.currentPage = Int(pageIndex)
//        print("SCROLLVIEWDIDSCROLL: \(pageIndex)")
        let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
        let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
        
        // vertical
        let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
        let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
        
        let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
        let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
