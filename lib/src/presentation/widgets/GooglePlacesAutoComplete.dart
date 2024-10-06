import 'package:flutter/material.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:google_places_autocomplete_text_field/model/prediction.dart';

class GooglePlacesAutoComplete extends StatelessWidget {
  TextEditingController controller;
  String hintText;
  IconData icon;
  Color color;
  String yourGoogleAPIKey;
  Function(Prediction prediction) onPlaceSelected;

  GooglePlacesAutoComplete(this.controller, this.hintText, this.icon,
      this.color, this.onPlaceSelected, this.yourGoogleAPIKey);

  @override
  Widget build(BuildContext context) {
    final size =
        MediaQuery.of(context).size; // Obtener el tamaño de la pantalla
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: GooglePlacesAutoCompleteTextFormField(
        textEditingController: controller,
        googleAPIKey: yourGoogleAPIKey,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.black45,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          prefixIcon: Icon(
            icon,
            color: color,
          ),
          // border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Porfavor, ingresa este campo';
          }
          return null;
        },
        // proxyURL: _yourProxyURL,
        maxLines: 1,
        overlayContainer: (child) => Material(
          elevation: 1.0,
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          child: child,
        ),
        countries: ["pe"],
        getPlaceDetailWithLatLng: onPlaceSelected,
        itmClick: (Prediction prediction) =>
            controller.text = prediction.description!,
      ),
    );
  }
}
