import SwiftUI
import PDFKit

struct AsyncPDFView: View {
  let pdfURL: URL
  
  var body: some View {
    PDFViewWrapper(pdfURL: pdfURL)
      .frame( width: 400, height: 800)
      .border(Color.gray, width: 2)
  }
}

struct PDFViewWrapper: UIViewRepresentable {
  let pdfURL: URL
  
  func makeUIView(context: Context) -> PDFView {
    let pdfView = PDFView()
    pdfView.backgroundColor = .clear
    pdfView.autoScales = true
    return pdfView
  }
  
  func updateUIView(_ uiView: PDFView, context: Context) {
    if let pdfDocument = PDFDocument(url: pdfURL) {
      uiView.document = pdfDocument
    } else {
      uiView.document = nil
    }
  }
}
