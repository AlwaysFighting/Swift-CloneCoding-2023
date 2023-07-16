//
//  MapView.swift
//  Corona19VaccineCenter
//
//  Created by 목정아 on 2023/07/16.
//

import SwiftUI
import MapKit

// Pin 표시를 위한 AnnotationItem
struct AnnotationItem: Identifiable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D // 좌표
}

struct MapView: View {
    var coordination: CLLocationCoordinate2D
    
    // 상태 표시 (이 뷰 내에서만 적용하는 -> 외부에서 영향 받지 X)
    @State private var region = MKCoordinateRegion()
    @State private var annotationItems = [AnnotationItem]()
        
    var body: some View {
        Map(
            // $ 표시 : 계속해서 주시하겠다는 의미
            coordinateRegion: $region,
            annotationItems: [AnnotationItem(coordinate: coordination)],
            annotationContent: {
                // 해당하는 좌표를 PIN 표시로 만들어주기
                MapMarker(coordinate: $0.coordinate)
            }
        )
        .onAppear {
            setRegion(coordination)
            setAnnotationItems(coordination)
        }
    }
    
    private func setRegion(_ coordinate: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(
            center: coordinate,
            // 0 에 가까울수록 맵이 확대되어지고 1에 가까울 수록 멀어진다.
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
    }
    
    private func setAnnotationItems(_ coordinate: CLLocationCoordinate2D) {
        annotationItems = [AnnotationItem(coordinate: coordinate)]
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        let center0 = Center(id: 0, sido: .경기도, facilityName: "실내빙상장 앞", address: "경기도 뫄뫄시 뫄뫄구", lat: "37.404476", lng: "126.9491998", centerType: .central, phoneNumber: "010-0000-0000")
        MapView(
            coordination: CLLocationCoordinate2D(
                latitude: CLLocationDegrees(center0.lat) ?? .zero,
                longitude: CLLocationDegrees(center0.lng) ?? .zero
            )
        )
    }
}

