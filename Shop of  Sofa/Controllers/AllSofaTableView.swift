//
//  AllSofaTableView.swift
//  Shop of  Sofa
//
//  Created by Сергей Косилов on 09/07/2019.
//  Copyright © 2019 Сергей Косилов. All rights reserved.
//





import UIKit


class AllSofaTableView: UITableViewController {

   var arraySofaForTable = [[Sofa]]()
    
    var allSofa: [Sofa]!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allSofa = Sofa.all
        arraySofaForTable = allSofa.separationOnGroup()
        print(allSofa.count)
        print(arraySofaForTable.count)
    }

 

    override func numberOfSections(in tableView: UITableView) -> Int {


        return arraySofaForTable.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return arraySofaForTable[section].count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellOfAllSofa", for: indexPath) as! CellOfAllSofa
        let sofa = arraySofaForTable[indexPath.section][indexPath.row]
        cell.nameOfSofa.text = sofa.name
        cell.imageOfSofa.image = UIImage(named: sofa.image.first!)
        cell.nameOfCollection.text = sofa.category.rawValue
        return cell
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       let button = UIButton(type: .system)
        button.setTitle("Закрыть", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(handleExplandClose), for: .touchUpInside)
        
        
        return button
    }
    
    @objc func handleExplandClose(){
        
        let section = 0
        var indexPaths = [IndexPath]()
        for row in arraySofaForTable[section].indices{
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        tableView.deleteRows(at: indexPaths, with: .fade)
        
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 34
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }


}


//
//extension Array where Element == Sofa{
//
//    func separationOnGroup() -> [[Sofa]]{
//
//
//        var allSofa = [[Sofa]]()
//        var cornerFabric = [Sofa]()
//        var cornerLeather = [Sofa]()
//        var cornerModular = [Sofa]()
//        var straightFabric = [Sofa]()
//        var straightLeather = [Sofa]()
//
//
//        for sofa in self{
//        if sofa.category == Category.cornerFabric {
//            cornerFabric.append(sofa)} else{
//            if sofa.category == Category.cornerLeather{
//                cornerLeather.append(sofa)
//            }else{
//        if sofa.category == Category.cornerModular{
//            cornerModular.append(sofa)}else{
//            if sofa.category == Category.straightFabric{
//                straightFabric.append(sofa)} else{
//                if sofa.category == Category.straightLeather{
//            straightLeather.append(sofa)
//                }}}}}}
//        allSofa.append(cornerModular)
//        allSofa.append(cornerLeather)
//        allSofa.append(cornerFabric)
//        allSofa.append(straightFabric)
//        allSofa.append(straightLeather)
//
//
//        return allSofa
//
//}
//
//}
extension Array where Element == Sofa{
    
    func separationOnGroup() -> [[Sofa]]{
        
        
        var allSofa = [[Sofa]]()
        var cornerFabric = [Sofa]()
        var cornerLeather = [Sofa]()
        var cornerModular = [Sofa]()
        var straightFabric = [Sofa]()
        var straightLeather = [Sofa]()
        
        for sofa in self{
        switch sofa.category {
        case .cornerFabric:
            cornerFabric.append(sofa)
            break
        case .straightLeather:
            straightLeather.append(sofa)
            break
        case .straightFabric:
            straightFabric.append(sofa)
            break
        case .cornerModular:
            cornerModular.append(sofa)
            break
        case .cornerLeather:
            cornerLeather.append(sofa)
            break
            }
        }
            
            
     
        allSofa.append(cornerModular)
        allSofa.append(cornerLeather)
        allSofa.append(cornerFabric)
        allSofa.append(straightFabric)
        allSofa.append(straightLeather)
        
        
        return allSofa
        
    }
    
}
