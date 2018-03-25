//
//  GistDetailViewController.swift
//  GistCommenter
//
//  Created Bruno Gama on 23/03/2018.
//  Copyright © 2018 Bruno Gama. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import SkeletonView
import UIKit

internal final class GistDetailViewController: UIViewController, UITableViewDelegate, GistDetailViewProtocol {

	var presenter: GistDetailPresenterProtocol?
    var datasource: (GistDetailDatasourceProtocol & UITableViewDataSource)?

    @IBOutlet private weak var tableView: UITableView!
    private var tableHeaderView: GistHeaderView?

    // MARK: - View life cycle
	override func viewDidLoad() {
        super.viewDidLoad()

        title = datasource?.title

        setupNavigationBar()
        setupTableView()
        presenter?.viewDidLoad()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView.zero()
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }

    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        let frame = CGRect(x: 0, y: 0, width: tableView.bounds.size.width,
                           height: self.tableView(tableView, heightForHeaderInSection: section))
        let view = GistHeaderView(frame: frame)
        view.title = section == 0 ? "Files inside the Gist" : "Comments"
        return view
    }

    // MARK: - GistDetailViewProtocol
    func show(comments: [GistComment]) {
        datasource?.data.value = comments
        hideLoading()
        tableView.reloadData()
    }

    func loading() {
        cleanTableFooterView()

        let activityViewSize = CGFloat(44)
        let tableFooterViewHeight = activityViewSize * 1.4
        let width = tableView.frame.size.width

        let footerViewFrame = CGRect(x: 0, y: 0, width: width, height: tableFooterViewHeight)
        let tableFooterView = UIView(frame: footerViewFrame)

        let indicatorView = activityIndicatorView(with: activityViewSize)
        tableFooterView.addSubview(indicatorView)
        addCenteringConstraints(indicatorView)
        tableView.tableFooterView = tableFooterView
        tableView.tableFooterView?.frame = tableFooterView.frame
    }

    func hideLoading() {
        cleanTableFooterView()
        tableView.reloadData()
        tableView.flashScrollIndicators()
    }

    func cleanTableFooterView() {
        tableView.tableFooterView?.subviews.flatMap { $0 as UIView }.forEach { $0.removeFromSuperview() }
        tableView.tableFooterView = UIView.zero()
    }

    func presentEmpty() {
        datasource?.data.value = []
        hideLoading()
        cleanTableFooterView()
        let text = L10n.noComments
        let label = emptyLabel(with: text)
        tableView.tableFooterView = label
        tableView.tableFooterView?.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 44)
        tableView.reloadData()
    }

    // MARK: Private methods
    fileprivate func setupTableView() {
        tableView.register(cellType: CommentTableViewCell.self)
        tableView.register(cellType: FileCell.self)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        tableView.dataSource = datasource
        tableView.delegate = self
        tableView.tableFooterView = UIView.zero()
        tableView.separatorInset = .zero
        tableView.separatorColor = Asset.Colors.lightGray.color.withAlphaComponent(0.5)
        tableView.reloadData()
    }

    fileprivate func setupNavigationBar() {
        navigationItem.title = title
        navigationItem.prompt = L10n.gistDetail
    }

    fileprivate func add(visualConstraints: [String], to views: [String: Any]) {
        visualConstraints.forEach { format in
            NSLayoutConstraint.constraints(withVisualFormat: format, options: .init(rawValue:0), metrics: nil,
                                           views: views).forEach { $0.isActive = true }
        }
    }

    fileprivate func addCenteringConstraints(_ toView: UIView) {
        toView.translatesAutoresizingMaskIntoConstraints = false
        add(visualConstraints: ["H:|[view]|", "V:|[view]|"], to: ["view": toView])
    }

    fileprivate func activityIndicatorView(with size: CGFloat) -> UIActivityIndicatorView {
        let activityIndicatiorViewFrame = CGRect(x: 0, y: 0, width: size, height: size)
        let activityIndicatiorView = UIActivityIndicatorView(frame: activityIndicatiorViewFrame)
        activityIndicatiorView.activityIndicatorViewStyle = .gray
        activityIndicatiorView.startAnimating()

        return activityIndicatiorView
    }

    fileprivate func emptyLabel(with text: String) -> UILabel {
        let emptyLabel = UILabel()
        emptyLabel.text = text
        emptyLabel.textColor = Asset.Colors.darkGray.color
        emptyLabel.sizeToFit()
        emptyLabel.textAlignment = .center

        return emptyLabel
    }
}

extension UITableView {
    func updatesViews(block: () -> Void) {
        beginUpdates()
        block()
        endUpdates()
    }
}

extension UIView {
    static func zero() -> UIView { return self.init(frame: CGRect.zero ) }
}
