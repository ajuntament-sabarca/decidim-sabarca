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

var map = L.map('map').setView([41.44863, 1.96835], 15);

L.tileLayer.here({
  maxZoom: 18,
  appId: hereAppId,
  appCode: hereAppCode
}).addTo(map);

function onclick(e) {
  current_url = window.location.href
  detail_url = "/"+ e.target.feature.properties.id_scope

  window.location.replace(current_url + detail_url)
}

function onEachFeature(feature, layer) {
	if (feature.properties && feature.properties.tooltipContent) {
		var tooltipContent = feature.properties.tooltipContent;
    layer.bindTooltip(tooltipContent)
	}
  layer.on({click: onclick});
}

L.geoJSON([sabarcaScopes], {

	style: function (feature) {
		return feature.properties && feature.properties.style;
	},

	onEachFeature: onEachFeature,

}).addTo(map);
