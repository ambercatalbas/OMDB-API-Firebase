//
//  HomeCell.swift
//  NoteMVVMR
//
//  Created by Amber Çatalbaş on 10.09.2022.
//

import UIKit
import TinyConstraints

public class HomeCell: UITableViewCell, ReusableView {
    public static var defaultReuseIdentifier = "HomeCell"
    
    weak var viewModel: HomeCellProtocol?
    
    private let titleLabel = VerticalAlignLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureContents()
    }
    
    private func configureContents() {
        addSubViews()
    }
    
}

extension HomeCell {
    
    public func set(viewModel: HomeCellProtocol) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.titleText
    }
    
    public func setData(_ item: HomeCellItem) {
        titleLabel.text = item.title
    }
}

extension HomeCell {
    
    private func addSubViews() {
        contentView.backgroundColor = .appWhite
        makeTitleLabel()
    }
    
    private func makeTitleLabel() {
        addSubview(titleLabel)
        titleLabel.topToSuperview().constant = 10
        titleLabel.bottomToSuperview().constant = -10
        titleLabel.leftToSuperview().constant = 12
        titleLabel.rightToSuperview().constant = -12
        titleLabel.verticalAlignment = .bottom
        titleLabel.font = .font(.josefinSansSemibold, size: .custom(size: 20))
        titleLabel.textAlignment = .left
        titleLabel.textColor = .appCinder
        titleLabel.numberOfLines = 0
    }
    
}

extension HomeCell {
    static func createCell(_ data: HomeSection, tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(indexPath, cell: HomeCell.self)
        cell.selectionStyle = .none
        if let item = data.items?[indexPath.row] as? HomeCellItem {
            cell.setData(item)
        }
        return cell
    }
}
