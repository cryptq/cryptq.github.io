stk.v.11.0
WrittenBy    STK_v11.4.0

BEGIN ReportStyle

    BEGIN ClassId
        Class		 Access
    END ClassId

    BEGIN Header
        StyleType		 0
        Date		 Yes
        Name		 Yes
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
            NumElements		 15

            BEGIN Element
                Name		 Time
                IsIndepVar		 Yes
                IndepVarName		 Time
                Title		 Time
                NameInTitle		 No
                Service		 InviewRadarEnvironment
                Element		 Time
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
                UseScenUnits		 No
                BEGIN Units
                    DateFormat		 YYYY:MM:DD:HH:MM:SS.sssTime
                END Units
            END Element

            BEGIN Element
                Name		 Radar Antenna-Xmtr Ant Gain
                IsIndepVar		 No
                IndepVarName		 Time
                Title		 Xmtr Ant Gain
                NameInTitle		 Yes
                Service		 InviewRadarAntenna
                Element		 Xmtr Ant Gain
                SumAllowedMask		 1543
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
                Name		 Radar Geometry-Xmtr Range
                IsIndepVar		 No
                IndepVarName		 Time
                Title		 Xmtr Range
                NameInTitle		 Yes
                Service		 InviewRadarGeometry
                Element		 Xmtr Range
                SumAllowedMask		 1543
                SummaryOnly		 No
                DataType		 0
                UnitType		 0
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
                Name		 Radar Environment-Xmtr Prop Atten
                IsIndepVar		 No
                IndepVarName		 Time
                Title		 Xmtr Prop Atten
                NameInTitle		 Yes
                Service		 InviewRadarEnvironment
                Element		 Xmtr Prop Atten
                SumAllowedMask		 1543
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
                Name		 Radar Geometry-Xmtr Prop Time
                IsIndepVar		 No
                IndepVarName		 Time
                Title		 Xmtr Prop Time
                NameInTitle		 Yes
                Service		 InviewRadarGeometry
                Element		 Xmtr Prop Time
                SumAllowedMask		 1543
                SummaryOnly		 No
                DataType		 0
                UnitType		 23
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
                    SmallTimeUnit		 Microseconds
                END Units
            END Element

            BEGIN Element
                Name		 Radar Environment-Target Doppler Shift
                IsIndepVar		 No
                IndepVarName		 Time
                Title		 Target Doppler Shift
                NameInTitle		 Yes
                Service		 InviewRadarEnvironment
                Element		 Target Doppler Shift
                SumAllowedMask		 1543
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
                Name		 Radar RCS-RCS
                IsIndepVar		 No
                IndepVarName		 Time
                Title		 RCS
                NameInTitle		 Yes
                Service		 InviewRadarRCS
                Element		 RCS
                SumAllowedMask		 1543
                SummaryOnly		 No
                DataType		 0
                UnitType		 25
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
                Name		 Radar Geometry-Rcvr Range
                IsIndepVar		 No
                IndepVarName		 Time
                Title		 Rcvr Range
                NameInTitle		 Yes
                Service		 InviewRadarGeometry
                Element		 Rcvr Range
                SumAllowedMask		 1543
                SummaryOnly		 No
                DataType		 0
                UnitType		 0
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
                Name		 Radar Environment-Rcvr Prop Atten
                IsIndepVar		 No
                IndepVarName		 Time
                Title		 Rcvr Prop Atten
                NameInTitle		 Yes
                Service		 InviewRadarEnvironment
                Element		 Rcvr Prop Atten
                SumAllowedMask		 1543
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
                Name		 Radar Geometry-Rcvr Prop Time
                IsIndepVar		 No
                IndepVarName		 Time
                Title		 Rcvr Prop Time
                NameInTitle		 Yes
                Service		 InviewRadarGeometry
                Element		 Rcvr Prop Time
                SumAllowedMask		 1543
                SummaryOnly		 No
                DataType		 0
                UnitType		 23
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
                    SmallTimeUnit		 Microseconds
                END Units
            END Element

            BEGIN Element
                Name		 Radar Environment-Rcvr Doppler Shift
                IsIndepVar		 No
                IndepVarName		 Time
                Title		 Rcvr Doppler Shift
                NameInTitle		 Yes
                Service		 InviewRadarEnvironment
                Element		 Rcvr Doppler Shift
                SumAllowedMask		 1543
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
                Name		 Radar SearchTrack-S/T Clutter Power
                IsIndepVar		 No
                IndepVarName		 Time
                Title		 S/T Clutter Power
                NameInTitle		 Yes
                Service		 InviewRadarSearchTrack
                Element		 S/T Clutter Power
                SumAllowedMask		 1543
                SummaryOnly		 No
                DataType		 0
                UnitType		 9
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
                    PowerUnit		 dBm
                END Units
            END Element

            BEGIN Element
                Name		 Radar SearchTrack-S/T SNR1
                IsIndepVar		 No
                IndepVarName		 Time
                Title		 S/T SNR1
                NameInTitle		 Yes
                Service		 InviewRadarSearchTrack
                Element		 S/T SNR1
                SumAllowedMask		 1543
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
                Name		 Radar SearchTrack-S/T C/N
                IsIndepVar		 No
                IndepVarName		 Time
                Title		 S/T C/N
                NameInTitle		 Yes
                Service		 InviewRadarSearchTrack
                Element		 S/T C/N
                SumAllowedMask		 1543
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
                Name		 Radar Antenna-Rcvr Ant Gain
                IsIndepVar		 No
                IndepVarName		 Time
                Title		 Rcvr Ant Gain
                NameInTitle		 Yes
                Service		 InviewRadarAntenna
                Element		 Rcvr Ant Gain
                SumAllowedMask		 1543
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
        END Line
    END Section

    BEGIN LineAnnotations
    END LineAnnotations
END ReportStyle

