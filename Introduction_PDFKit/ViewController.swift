//
//  ViewController.swift
//  Introduction_PDFKit
//
//  Created by 新垣 清奈 on 2022/08/26.
//

import UIKit
import PDFKit

class ViewController: UIViewController, PDFViewDelegate {

    private let pdfView = PDFView()
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Tap!", for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemGreen
        button.tintColor = .white
        return button
    }()
    private let pdfThumbnailView = PDFThumbnailView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(pdfView)
        view.addSubview(button)
        view.addSubview(pdfThumbnailView)
        button.addTarget(self, action: #selector(changeView), for: .touchUpInside)
        // Documents
        guard let url = Bundle.main.url(forResource: "DIC_Swatch_ReadMe", withExtension: "pdf"),
        let document = PDFDocument(url: url)  else { return }
        pdfView.document = document
        pdfView.autoScales = true
        pdfView.delegate = self

        pdfThumbnailView.pdfView = pdfView
        pdfThumbnailView.layoutMode = .horizontal
        pdfThumbnailView.backgroundColor = .darkGray
        pdfThumbnailView.thumbnailSize = CGSize(width: 40, height: 50)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pdfView.frame = view.bounds
        button.frame = CGRect(x: 20, y: view.frame.height-130, width: view.frame.width-40, height: 40)
        pdfThumbnailView.frame = CGRect(x: 0, y: view.frame.height-80, width: view.frame.width, height: 80)
    }

    @objc func changeView() {
        let mode: PDFDisplayMode
        print("Tapped!!")
        switch pdfView.displayMode {
        case .singlePage:
            mode = .singlePage
        case .singlePageContinuous:
            mode = .singlePageContinuous
        case .twoUp:
            mode = .twoUp
        case .twoUpContinuous:
            mode = .twoUpContinuous
        @unknown default:
            fatalError()
        }
        pdfView.displayMode = mode
    }
}
