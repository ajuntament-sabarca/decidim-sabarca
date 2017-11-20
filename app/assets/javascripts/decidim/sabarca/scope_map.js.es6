// = require leaflet
// = require leaflet-tilelayer-here
// = require leaflet-svg-icon
// = require leaflet.markercluster
// = require jquery-tmpl
// = require_self

L.DivIcon.SVGIcon.DecidimIcon = L.DivIcon.SVGIcon.extend({
  options: {
    fillColor: '#ef604d',
    opacity: 0
  },
  _createPathDescription: function() {
    return 'M14 1.17a11.685 11.685 0 0 0-11.685 11.685c0 11.25 10.23 20.61 10.665 21a1.5 1.5 0 0 0 2.025 0c0.435-.435 10.665-9.81 10.665-21A11.685 11.685 0 0 0 14 1.17Zm0 17.415A5.085 5.085 0 1 1 19.085 13.5 5.085 5.085 0 0 1 14 18.585Z';
  },
  _createCircle: function() {
    return ""
  }
});

const popupTemplateId = 'marker-popup';
$.template(popupTemplateId, $(`#${popupTemplateId}`).html());

const addMarkers = (markersData, markerClusters, map) => {
  const bounds = new L.LatLngBounds(markersData.map((markerData) => [markerData.latitude, markerData.longitude]));

  markersData.forEach((markerData) => {
    let marker = L.marker([markerData.latitude, markerData.longitude], {
      icon: new L.DivIcon.SVGIcon.DecidimIcon()
    });
    let node = document.createElement('div');

    $.tmpl(popupTemplateId, markerData).appendTo(node);

    marker.bindPopup(node, {
      maxwidth: 640,
      minWidth: 500,
      keepInView: true,
      className: 'map-info'
    }).openPopup();

    markerClusters.addLayer(marker);
  });

  map.addLayer(markerClusters);
  map.fitBounds(bounds, { padding: [100, 100] });
};

const loadMap = (mapId, markersData) => {
  let markerClusters = L.markerClusterGroup();
  const { hereAppId, hereAppCode } = window.Decidim.mapConfiguration;

  if (window.Decidim.currentMap) {
    window.Decidim.currentMap.remove();
    window.Decidim.currentMap = null;
  }

  const map = L.map(mapId).setView([41.44863, 1.96835], 15);

  L.tileLayer.here({
    appId: hereAppId,
    appCode: hereAppCode
  }).addTo(map);


  function onclick(e) {
    var current_url = window.location.href.split("?")[0];
    var detail_url = "/"+ e.target.feature.properties.id_scope;

    window.location = current_url + detail_url
  }

  function onEachFeature(feature, layer) {
  	if (feature.properties && feature.properties.name) {
  		var tooltipContent = feature.properties.name;
      layer.bindTooltip(tooltipContent);
  	}
    if (feature.properties && feature.properties.id_scope){
      layer.on({click: onclick});
    }
  }

  L.geoJSON([sabarcaScopes], {

  	style: function (feature) {
  		return feature.properties && feature.properties.style;
  	},

  	onEachFeature: onEachFeature,

  }).addTo(map);

  if (markersData.length > 0) {
    addMarkers(markersData, markerClusters, map);
  }

  map.scrollWheelZoom.disable();

  return map;
};

window.Decidim = window.Decidim || {};

window.Decidim.loadMap = loadMap;
window.Decidim.currentMap =  null;
window.Decidim.mapConfiguration = {};

$(() => {
  const mapId = 'map';
  const $map = $(`#${mapId}`);

  const markersData = $map.data('markers-data');
  const hereAppId = $map.data('here-app-id');
  const hereAppCode = $map.data('here-app-code');

  window.Decidim.mapConfiguration = { hereAppId, hereAppCode };

  if ($map.length > 0) {
    window.Decidim.currentMap = loadMap(mapId, markersData);
  }
});
