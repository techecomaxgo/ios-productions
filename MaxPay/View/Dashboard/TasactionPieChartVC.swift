//
//  TasactionPieChartVC.swift
//  MaxPay
//
//  Created by india on 13/12/23.
//

import UIKit
import PieCharts

class TasactionPieChartVC: BaseVC,PieChartDelegate {
    
    @IBOutlet weak var vwPie: PieChart!
    @IBOutlet weak var tblPercentage: UITableView!
    fileprivate static let alpha: CGFloat = 0.5
        let colors = [
            UIColor.yellow.withAlphaComponent(alpha),
            UIColor.green.withAlphaComponent(alpha),
            UIColor.purple.withAlphaComponent(alpha),
            UIColor.cyan.withAlphaComponent(alpha),
            UIColor.darkGray.withAlphaComponent(alpha),
            UIColor.red.withAlphaComponent(alpha),
            UIColor.magenta.withAlphaComponent(alpha),
            UIColor.orange.withAlphaComponent(alpha),
            UIColor.brown.withAlphaComponent(alpha),
            UIColor.lightGray.withAlphaComponent(alpha),
            UIColor.gray.withAlphaComponent(alpha),
        ]
    fileprivate var currentColorIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        tblPercentage.register(
            UINib(nibName: "TrasactionPercentageCell", bundle: nil),
            forCellReuseIdentifier: "TrasactionPercentageCell")
        self.vwPie.layers = [createPlainTextLayer(), createTextWithLinesLayer()]
        vwPie.delegate = self
        vwPie.models = createModels()
    }
    fileprivate func createModels() -> [PieSliceModel] {
     
     
            let models = [
                PieSliceModel(value: 12, color: colors[0],obj: "Recharge"),
                PieSliceModel(value: 20, color: colors[1],obj: "Transfer"),
                PieSliceModel(value: 27, color: colors[4],obj: "Food"),
                PieSliceModel(value: 62, color: colors[3],obj: "Entiterment"),
                PieSliceModel(value: 50, color: colors[2],obj: "Television"),
                PieSliceModel(value: 10, color: colors[5],obj: "Loan")
            ]
            
            currentColorIndex = models.count
            return models
        }
     
     fileprivate func createPlainTextLayer() -> PiePlainTextLayer {
            
            let textLayerSettings = PiePlainTextLayerSettings()
            textLayerSettings.viewRadius = 55
            textLayerSettings.hideOnOverflow = true
            textLayerSettings.label.font = UIFont.systemFont(ofSize: 8)
            
            let formatter = NumberFormatter()
            formatter.maximumFractionDigits = 1
            textLayerSettings.label.textGenerator = {slice in
                return formatter.string(from: slice.data.percentage * 100 as NSNumber).map{"\($0)%"} ?? ""
            }
            
            let textLayer = PiePlainTextLayer()
            textLayer.settings = textLayerSettings
            return textLayer
        }
        
        fileprivate func createTextWithLinesLayer() -> PieLineTextLayer {
            let lineTextLayer = PieLineTextLayer()
            var lineTextLayerSettings = PieLineTextLayerSettings()
            lineTextLayerSettings.lineColor = UIColor.lightGray
            let formatter = NumberFormatter()
            formatter.maximumFractionDigits = 1
            lineTextLayerSettings.label.font = UIFont.systemFont(ofSize: 14)
            lineTextLayerSettings.label.textGenerator = {slice in
                return formatter.string(from: slice.data.model.value as NSNumber).map{"\($0)"} ?? ""
            }
            
            lineTextLayer.settings = lineTextLayerSettings
            return lineTextLayer
        }
    func onSelected(slice: PieCharts.PieSlice, selected: Bool) {
        
    }

}
extension TasactionPieChartVC:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vwPie.models.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "TrasactionPercentageCell", for: indexPath) as! TrasactionPercentageCell
        cell.selectionStyle = .none
        cell.lblName.text! = vwPie.models[indexPath.row].obj as! String
        cell.vwColor.backgroundColor = vwPie.models[indexPath.row].color
        return cell
    }
}
