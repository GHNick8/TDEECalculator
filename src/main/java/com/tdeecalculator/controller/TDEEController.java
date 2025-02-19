package com.tdeecalculator.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class TDEEController {

    @GetMapping("/")
    public String home() {
        return "index";
    }

    @PostMapping("/calculate")
    public String calculateTDEE(
            @RequestParam double weight,      // Gewicht in kg
            @RequestParam double height,      // Lengte in cm
            @RequestParam int age,            // Leeftijd
            @RequestParam String gender,      // "male" of "female"
            @RequestParam double activityLevel, // Activiteitsfactor
            Model model) {

        // BMR Berekening (Harris-Benedict formule)
        double bmr;
        if ("male".equalsIgnoreCase(gender)) {
            bmr = 88.36 + (13.4 * weight) + (4.8 * height) - (5.7 * age);
        } else {
            bmr = 447.6 + (9.2 * weight) + (3.1 * height) - (4.3 * age);
        }

        // TDEE Berekening
        double tdee = bmr * activityLevel;

        // Afronden op 2 decimalen
        String formattedBMR = String.format("%.2f", bmr);
        String formattedTDEE = String.format("%.2f", tdee);

        // Resultaten doorgeven aan Thymeleaf
        model.addAttribute("bmr", formattedBMR);
        model.addAttribute("tdee", formattedTDEE);

        return "result";
    }
}
