//
//  ViewController.swift
//  TabelandImage
//
//  Created by Алина on 7/6/21.
//

import UIKit

class ViewController: UIViewController {
    var currentSeletedIndex = -1
    var imViC: ImageViewController?
    @IBOutlet weak var tableView: UITableView!
    var ssilka: [String] = ["https://thumb.tildacdn.com/tild6332-3265-4436-a636-323461643033/-/cover/720x720/center/center/-/format/webp/noroot.png", "https://n1s1.hsmedia.ru/b8/82/5d/b8825d119b96cd6195f937b40cee77b4/620x429_1_5a99f0bf75b4d863cc9ccf9f79ede1a3@1200x831_0xac120003_19189325441604046771.jpg", "https://icdn.lenta.ru/images/2019/12/29/16/20191229162041144/square_320_2a52d71f0769205ebd25396d44b2b755.png"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imViC = UIStoryboard(name: "Main",
                             bundle: nil).instantiateViewController(identifier: "secVC") as? ImageViewController
        
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ssilka.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentName = ssilka[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        cell?.textLabel?.text = currentName
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentSeletedIndex = indexPath.row
        guard let vc = imViC else { return }
        _ = vc.view
        DispatchQueue.global(qos: .background).async {
            if let imageURL = URL(string: self.ssilka[indexPath.row]) {
                if let imageData = try? Data(contentsOf: imageURL) {
                    let image = UIImage(data: imageData)
                    DispatchQueue.main.async {
                        vc.imageView.image = image
                        self.navigationController?.show(vc, sender: nil)
                    }
                }
            }
        }
    }
}
