START TRANSACTION//
CREATE TEMPORARY TABLE `UniqueReports` (
  `report_id` varchar(100) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(1000) DEFAULT 'TAS Report',
  `derived_from` varchar(1000) DEFAULT NULL,
  `title` varchar(1000) DEFAULT 'TAS Report',
  `header` varchar(1000) DEFAULT NULL,
  `footer` varchar(1000) DEFAULT NULL,
  `format` enum('Pdf','Pptx','Doc','Xls','Html') NOT NULL DEFAULT 'Pdf',
  `schedule` enum('Once','Daily','Weekly','Monthly','Quarterly','Semi-annually','Annually') NOT NULL DEFAULT 'Once',
  `delivery` enum('Download','E-mail') NOT NULL DEFAULT 'E-mail',
  `selected` tinyint(1) NOT NULL DEFAULT 0,
  `charts_per_page` int(1) DEFAULT NULL,
  `active_role` varchar(30) DEFAULT NULL,
  `last_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  UNIQUE INDEX idx_report (report_id),
  UNIQUE INDEX idx_user (user_id, name)
)//
INSERT IGNORE INTO `UniqueReports` SELECT * FROM Reports//
DELETE FROM Reports//
INSERT INTO Reports SELECT * FROM UniqueReports//
COMMIT//
