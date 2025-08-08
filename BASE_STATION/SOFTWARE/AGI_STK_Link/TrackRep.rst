stk.v.11.0
WrittenBy    STK_v11.3.0

BEGIN ReportStyle

    BEGIN ClassId
        Class		 Access
    END ClassId

    BEGIN Header
        StyleType		 0
        Date		 No
        Name		 No
        IsHidden		 No
        DescShort		 No
        DescLong		 No
        YLog10		 No
        Y2Log10		 No
        YUseWholeNumbers		 No
        Y2UseWholeNumbers		 No
        VerticalGridLines		 No
        HorizontalGridLines		 No
        AnnotationType		 Spaced
        NumAnnotations		 3
        NumAngularAnnotations		 5
        ShowYAnnotations		 Yes
        AnnotationRotation		 1
        BackgroundColor		 #ffffff
        ForegroundColor		 #000000
        ViewableDuration		 3600
        RealTimeMode		 No
        DayLinesStatus		 1
        LegendStatus		 1
        LegendLocation		 1

        BEGIN PostProcessor
            Destination		 0
            Use		 0
            Destination		 1
            Use		 0
            Destination		 2
            Use		 0
            Destination		 3
            Use		 0
        END PostProcessor
        NumSections		 1
    END Header

    BEGIN Section
        Name		 Section 1
        ClassName		 Access
        NameInTitle		 No
        ExpandMethod		 0
        PropMask		 2
        ShowIntervals		 No
        NumIntervals		 0
        NumLines		 1

        BEGIN Line
            Name		 Line 1
            NumElements		 7

            BEGIN Element
                Name		 Time
                IsIndepVar		 Yes
                IndepVarName		 Time
                Title		 Time
                NameInTitle		 No
                Service		 InviewAER
                Type		 NorthEastDown
                Element		 Time
                Format		 %.3f
                SumAllowedMask		 0
                SummaryOnly		 No
                DataType		 0
                UnitType		 2
                LineStyle		 0
                LineWidth		 0
                PointStyle		 0
                PointSize		 0
                FillPattern		 0
                LineColor		 #000000
                FillColor		 #000000
                PropMask		 0
                BEGIN Event
                    UseEvent		 No
                    EventValue		 0
                    Convergence		 0.002
                    Direction		 Both
                    CreateFile		 No
                END Event
                UseScenUnits		 No
                BEGIN Units
                    DateFormat		 YYYY:MM:DD:HH:MM:SS.sssTime
                END Units
            END Element

            BEGIN Element
                Name		 AER Data-Default-Azimuth
                IsIndepVar		 No
                IndepVarName		 Time
                Title		 Azimuth
                NameInTitle		 Yes
                Service		 InviewAER
                Type		 Default
                Element		 Azimuth
                SumAllowedMask		 1543
                SummaryOnly		 No
                DataType		 0
                UnitType		 20
                LineStyle		 0
                LineWidth		 0
                PointStyle		 0
                PointSize		 0
                FillPattern		 0
                LineColor		 #000000
                FillColor		 #000000
                PropMask		 0
                UseScenUnits		 Yes
            END Element

            BEGIN Element
                Name		 AER Data-Default-Elevation
                IsIndepVar		 No
                IndepVarName		 Time
                Title		 Elevation
                NameInTitle		 Yes
                Service		 InviewAER
                Type		 Default
                Element		 Elevation
                SumAllowedMask		 1543
                SummaryOnly		 No
                DataType		 0
                UnitType		 3
                LineStyle		 0
                LineWidth		 0
                PointStyle		 0
                PointSize		 0
                FillPattern		 0
                LineColor		 #000000
                FillColor		 #000000
                PropMask		 0
                UseScenUnits		 Yes
            END Element

            BEGIN Element
                Name		 Link Information-Prop Loss
                IsIndepVar		 No
                IndepVarName		 Time
                Title		 Prop Loss
                NameInTitle		 Yes
                Service		 LinkInfo
                Element		 Prop Loss
                SumAllowedMask		 1567
                SummaryOnly		 No
                DataType		 0
                UnitType		 24
                LineStyle		 0
                LineWidth		 0
                PointStyle		 0
                PointSize		 0
                FillPattern		 0
                LineColor		 #000000
                FillColor		 #000000
                PropMask		 0
                UseScenUnits		 Yes
            END Element

            BEGIN Element
                Name		 Link Information-Propagation Delay
                IsIndepVar		 No
                IndepVarName		 Time
                Title		 Propagation Delay
                NameInTitle		 Yes
                Service		 LinkInfo
                Element		 Propagation Delay
                Format		 %.9e
                SumAllowedMask		 0
                SummaryOnly		 No
                DataType		 0
                UnitType		 1
                LineStyle		 0
                LineWidth		 0
                PointStyle		 0
                PointSize		 0
                FillPattern		 0
                LineColor		 #000000
                FillColor		 #000000
                PropMask		 0
                BEGIN Event
                    UseEvent		 No
                    EventValue		 0
                    Convergence		 0.002
                    Direction		 Both
                    CreateFile		 No
                END Event
                UseScenUnits		 Yes
            END Element

            BEGIN Element
                Name		 Link Information-Freq. Doppler Shift
                IsIndepVar		 No
                IndepVarName		 Time
                Title		 Freq. Doppler Shift
                NameInTitle		 Yes
                Service		 LinkInfo
                Element		 Freq. Doppler Shift
                SumAllowedMask		 1567
                SummaryOnly		 No
                DataType		 0
                UnitType		 10
                LineStyle		 0
                LineWidth		 0
                PointStyle		 0
                PointSize		 0
                FillPattern		 0
                LineColor		 #000000
                FillColor		 #000000
                PropMask		 0
                UseScenUnits		 No
                BEGIN Units
                    FrequencyUnit		 Hertz
                END Units
            END Element

            BEGIN Element
                Name		 Link Information-Tequivalent
                IsIndepVar		 No
                IndepVarName		 Time
                Title		 Tequivalent
                NameInTitle		 Yes
                Service		 LinkInfo
                Element		 Tequivalent
                SumAllowedMask		 1567
                SummaryOnly		 No
                DataType		 0
                UnitType		 22
                LineStyle		 0
                LineWidth		 0
                PointStyle		 0
                PointSize		 0
                FillPattern		 0
                LineColor		 #000000
                FillColor		 #000000
                PropMask		 0
                UseScenUnits		 Yes
            END Element
        END Line
    END Section

    BEGIN LineAnnotations
        BEGIN Line
            ShowAnnotation		 No
            LineType		 2
            LineColor		 #000000
            LineStyle		 0
            LineWidth		 0
            LineValue		 0
            LineUseCurrent		 Yes
            LineShowLabel		 No
            UnitType		 0
        END Line
    END LineAnnotations
END ReportStyle

