//
//  MyViewController.swift
//  PokeAPIStoryBoard
//
//  Created by Jorge Agullo Martin on 16/2/22.
//

import UIKit

class MyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MyCellDelegate {
    
    
    @IBOutlet weak var MyTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    func callPressed(name: String) {
        <#code#>
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
