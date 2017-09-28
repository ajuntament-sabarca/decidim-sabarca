// = require leaflet
// = require leaflet-tilelayer-here
// = require leaflet-svg-icon
// = require leaflet.markercluster
// = require jquery-tmpl
// = require_self

var mapId = 'map';
var $map = $(`#${mapId}`);

var hereAppId = $map.data('here-app-id');
var hereAppCode = $map.data('here-app-code');

var map = L.map('map').setView([41.451980, 1.954392], 13);

  L.tileLayer.here({
    appId: hereAppId,
    appCode: hereAppCode
  }).addTo(map);

	// var baseballIcon = L.icon({
	// 	iconUrl: 'baseball-marker.png',
	// 	iconSize: [32, 37],
	// 	iconAnchor: [16, 37],
	// 	popupAnchor: [0, -28]
	// });

	function onEachFeature(feature, layer) {
		var popupContent = "<p>I started out as a GeoJSON " +
				feature.geometry.type + ", but now I'm a Leaflet vector!</p>";

		if (feature.properties && feature.properties.popupContent) {
			popupContent += feature.properties.popupContent;
		}

		layer.bindPopup(popupContent);
	}

	L.geoJSON(campus, {

		style: function (feature) {
			return feature.properties && feature.properties.style;
		},

		onEachFeature: onEachFeature,

		// pointToLayer: function (feature, latlng) {
		// 	return L.circleMarker(latlng, {
		// 		radius: 8,
		// 		fillColor: "#ff7800",
		// 		color: "#000",
		// 		weight: 1,
		// 		opacity: 1,
		// 		fillOpacity: 0.8
		// 	});
		// }
	}).addTo(map);

	// L.geoJSON(freeBus, {
  //
	// 	filter: function (feature, layer) {
	// 		if (feature.properties) {
	// 			// If the property "underConstruction" exists and is true, return false (don't render features under construction)
	// 			return feature.properties.underConstruction !== undefined ? !feature.properties.underConstruction : true;
	// 		}
	// 		return false;
	// 	},
  //
	// 	onEachFeature: onEachFeature
	// }).addTo(map);

	// var coorsLayer = L.geoJSON(coorsField, {
  //
	// 	pointToLayer: function (feature, latlng) {
	// 		return L.marker(latlng, {icon: baseballIcon});
	// 	},
  //
	// 	onEachFeature: onEachFeature
	// }).addTo(map);

/////// FINS AKI
//
// L.DivIcon.SVGIcon.DecidimIcon = L.DivIcon.SVGIcon.extend({
//   options: {
//     fillColor: '#ef604d',
//     opacity: 0
//   },
//   _createPathDescription: function() {
//     return 'M14 1.17a11.685 11.685 0 0 0-11.685 11.685c0 11.25 10.23 20.61 10.665 21a1.5 1.5 0 0 0 2.025 0c0.435-.435 10.665-9.81 10.665-21A11.685 11.685 0 0 0 14 1.17Zm0 17.415A5.085 5.085 0 1 1 19.085 13.5 5.085 5.085 0 0 1 14 18.585Z';
//   },
//   _createCircle: function() {
//     return ""
//   }
// });
//
// const popupTemplateId = 'marker-popup';
// $.template(popupTemplateId, $(`#${popupTemplateId}`).html());
//
// const addMarkers = (markersData, markerClusters, map) => {
//   const bounds = new L.LatLngBounds(markersData.map((markerData) => [markerData.latitude, markerData.longitude]));
//
//   // markersData.forEach((markerData) => {
//   //   let marker = L.marker([markerData.latitude, markerData.longitude], {
//   //     icon: new L.DivIcon.SVGIcon.DecidimIcon()
//   //   });
//   //   let node = document.createElement('div');
//   //
//   //   $.tmpl(popupTemplateId, markerData).appendTo(node);
//   //
//   //   marker.bindPopup(node, {
//   //     maxwidth: 640,
//   //     minWidth: 500,
//   //     keepInView: true,
//   //     className: 'map-info'
//   //   }).openPopup();
//   //
//   //   markerClusters.addLayer(marker);
//   // });
//
//   map.addLayer(markerClusters);
//   map.fitBounds(bounds, { padding: [100, 100] });
// };
//
//
// const loadMap = (mapId, markersData, scopes ) => {
//   let markerClusters = L.markerClusterGroup();
//   const { hereAppId, hereAppCode } = window.Decidim.mapConfiguration;
//
//   if (window.Decidim.currentMap) {
//     window.Decidim.currentMap.remove();
//     window.Decidim.currentMap = null;
//   }
//
//   const map = L.map(mapId);
//
//   L.tileLayer.here({
//     appId: hereAppId,
//     appCode: hereAppCode
//   }).addTo(map);
//   //
//   // var scopesData1 = [
//   //   [ // first polygon
//   //     [, , , ]
//   //   ],
//   //   [ // second polygon
//   //     [, , , ]
//   //   ]
//   // ];
//
//   var states = [{
//     "type": "Feature",
//     "properties": {"party": "Republican"},
//     "geometry": {
//         "type": "Polygon",
//         "coordinates": [[
//             [41.451980, 1.954392],
//             [41.452286, 1.955272],
//             [41.452286, 1.955272],
//             [41.450835, 1.955882]
//         ]]
//     }
//   }, {
//       "type": "Feature",
//       "properties": {"party": "Democrat"},
//       "geometry": {
//           "type": "Polygon",
//           "coordinates": [[
//               [41.450956, 1.958127],
//               [41.450363, 1.958939],
//               [41.449056, 1.957870],
//               [41.449345, 1.957079]
//           ]]
//       }
//   }];
//
//   // L.geoJSON(states, {
//   //     style: function(feature) {
//   //         switch (feature.properties.party) {
//   //             case 'Republican': return {color: "#ff0000"};
//   //             case 'Democrat':   return {color: "#0000ff"};
//   //         }
//   //     }
//   // }).addTo(map);
//   L.geoJSON(geojsonFeature, {
//     onEachFeature: onEachFeature
// }).addTo(map);
//
//
//   // // var poly1 = L.polygon(coordinatesForPolygon1).bindPopup('One');
//   // // var poly2 = L.polygon(coordinatesForPolygon2).bindPopup('Two');
//   // //
//   // // var polygon = L.polygon(scopesData, {color: 'red'}).addTo(map);
//   // polygon.on('click', function(e) {
//   //   alert(e.latlng);
//   // } );
//
//   if (markersData.length > 0) {
//     addMarkers(markersData, markerClusters, map);
//   } else {
//     map.fitWorld();
//   }
//
//   // map.scrollWheelZoom.disable();
//
//   return map;
// };
//
// window.Decidim = window.Decidim || {};
//
// window.Decidim.loadMap = loadMap;
// window.Decidim.currentMap =  null;
// window.Decidim.mapConfiguration = {};
//
// $(() => {
//   const mapId = 'map';
//   const $map = $(`#${mapId}`);
//
//   // const markersData = $map.data('markers-data');
//   const markersData = [{"latitude":41.44882,"longitude":1.95421},{"latitude":41.44882,"longitude":1.95421}];
//   const scopesData = [
//     [ // first polygon
//       [[37, -109.05],[41, -109.03],[41, -102.05],[37, -102.04]], // outer ring
//     ],
//     [ // second polygon
//       [[41, -111.03],[45, -111.04],[45, -104.05],[41, -104.05]]
//     ]
//   ];
//
//   const hereAppId = $map.data('here-app-id');
//   const hereAppCode = $map.data('here-app-code');
//
//   window.Decidim.mapConfiguration = { hereAppId, hereAppCode };
//
//   if ($map.length > 0) {
//     window.Decidim.currentMap = loadMap(mapId, markersData);
//   }
// });
